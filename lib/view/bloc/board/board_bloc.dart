import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbanboard/application/constants/app_constants.dart';
import 'package:kanbanboard/application/core/extensions/extensions.dart';
import 'package:kanbanboard/application/core/helpers/date_time_helper.dart';
import 'package:kanbanboard/application/services/pref_service/i_pref_service.dart';
import 'package:kanbanboard/data/models/section.dart';
import 'package:kanbanboard/domain/entities/update_task_entity.dart';
import 'package:kanbanboard/domain/repo_interfaces/i_board_repo.dart';
import 'package:kanbanboard/domain/use_cases/create_task_usecase.dart';
import 'package:kanbanboard/domain/use_cases/get_tasks_usecase.dart';
import 'package:kanbanboard/domain/use_cases/update_tasks_usecase.dart';
import 'package:kanbanboard/view/board_view/kanban_board_view.dart';
import 'package:kanbanboard/view/board_view/model/card_item_data.dart';

import '../../../data/models/task.dart';
import '../../../application/constants/temp_data.dart';
import 'board_event.dart';
import 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final IBoardRepo boardRepo;
  final IPrefService prefService;

  BoardBloc({
    required this.boardRepo,
    required this.prefService,
  }) : super(BoardInitial()) {
    on<FetchTasks>(_onFetchTasks);
    on<MoveTask>(_onMoveTask);
    on<CreateTaskEvent>(_createTask);
  }

  Future<void> _createTask(
    CreateTaskEvent event,
    Emitter<BoardState> emit,
  ) async {
    final result = await CreateTaskUseCase(boardRepo).call(UpdateTaskEntity(
      sectionId: event.params.sectionId,
    ));

    result.fold((failure) {
      emit(BoardError(failure.message.asString));
    }, (newTask) {
      event.controller.addGroupItem(
          newTask.sectionId.asString, CardItemData(task: newTask));
    });
  }

  Future<void> _onFetchTasks(FetchTasks event, Emitter<BoardState> emit) async {
    emit(BoardLoading(sections: sectionsL));
    final tasksOrFailure =
        await GetTasksUseSase(boardRepo).call(AppConstants.projectId);

    tasksOrFailure.fold(
      (failure) {
        emit(BoardError(failure.message.asString));
      },
      (tasks) async {
        final taskGroupBySectionId =
            _groupTasksBySection(tasks, (state as BoardLoading).sections);
        final groups = _generateAppFlowyGroups(
            taskGroupBySectionId.$1, (state as BoardLoading).sections);
        emit(BoardLoaded(
          tasks: tasks,
          sections: (state as BoardLoading).sections,
          taskGroupBySectionId: taskGroupBySectionId.$2,
          groups: groups,
        ));
      },
    );
  }

  Future<void> _onMoveTask(MoveTask event, Emitter<BoardState> emit) async {
    final currentState = state;
    if (currentState is BoardLoaded) {
      if (!event.crossSection) {
        // _saveTaskOrder(event.toSectionId, event.toIndex, updatedTasks);
      }

      final updatedTasks = _updateTaskCrossOrder(
        currentState.taskGroupBySectionId,
        event.fromSectionId,
        event.fromIndex,
        event.toSectionId,
        event.toIndex,
      );

      final groups =
          _generateAppFlowyGroups(updatedTasks, currentState.sections);
      emit(BoardLoaded(
        tasks: updatedTasks.values.expand((tasks) => tasks).toList(),
        sections: currentState.sections,
        taskGroupBySectionId: updatedTasks,
        groups: groups,
      ));

      _saveTaskOrder(event.toSectionId, event.toIndex, updatedTasks);
    }
  }

  addNewTask(
    String sectionId,
  ) {}

  List<AppFlowyGroupData> _generateAppFlowyGroups(
      Map<String, List<Task>> taskGroupBySectionId, List<Section> sections) {
    final List<AppFlowyGroupData> groups = [];
    taskGroupBySectionId.forEach((sectionId, tasks) {
      final section = sections.firstWhere((element) => element.id == sectionId);
      final group = AppFlowyGroupData(
        id: sectionId,
        name: section.name.asString,
        items: List<AppFlowyGroupItem>.from(tasks.map((task) {
          return CardItemData(task: task);
        }).toList()),
      );
      groups.add(group);
    });
    return groups;
  }

  /// all task except completed, including completed tasks
  (Map<String, List<Task>>, Map<String, List<Task>>) _groupTasksBySection(
      List<Task> tasks, List<Section> sections) {
    final groupedData = <String, List<Task>>{};
    for (var section in sections) {
      groupedData[section.id.asString] =
          tasks.where((task) => task.sectionId == section.id).toList();
    }

    final sortedMap = <String, List<Task>>{};

    groupedData.forEach((sectionId, sectionTasks) {
      if (sectionId == completedSection) {
        return;
      }

      final orders = _getTaskOrder(sectionId);
      if (orders == null || orders.isEmpty) {
        // If no order is specified, keep the tasks as they are
        sortedMap[sectionId] = sectionTasks;
      } else {
        // Sort the tasks based on the order provided
        sectionTasks.sort((a, b) {
          int indexA = orders.indexOf(a.id!);
          int indexB = orders.indexOf(b.id!);
          if (indexA == -1) return 1; // Place a at the end if not found
          if (indexB == -1) return -1; // Place b at the end if not found
          return indexA.compareTo(indexB);
        });
        // Assign the sorted tasks to the section in the sorted map
        sortedMap[sectionId] = sectionTasks;
      }
    });
    return (sortedMap, groupedData);
  }

  Map<String, List<Task>> _updateTaskCrossOrder(
    Map<String, List<Task>> taskGroupBySectionId,
    String fromSectionId,
    int fromIndex,
    String toSectionId,
    int toIndex,
  ) {
    final updatedTasks = Map<String, List<Task>>.from(taskGroupBySectionId);
    final movedTask = updatedTasks[fromSectionId]!.removeAt(fromIndex);
    updatedTasks[toSectionId]!.insert(toIndex, movedTask);
    return updatedTasks;
  }

  void _saveTaskOrder(String sectionId, int changedTaskIndex,
      Map<String, List<Task>> taskGroupBySectionId) {
    final taskIds =
        taskGroupBySectionId[sectionId]!.map((task) => task.id!).toList();
    prefService.setStringList('task_order_$sectionId', taskIds);
    final taskId = taskIds[changedTaskIndex];
    UpdateTasksUseCase(boardRepo)
        .call(UpdateTaskEntity(taskId: taskId, sectionId: sectionId));
  }

  List<String>? _getTaskOrder(String sectionId) {
    final taskOrder = prefService.getStringList('task_order_$sectionId');
    return taskOrder;
  }
}
