import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbanboard/application/core/logger/app_logging.dart';
import 'package:kanbanboard/domain/entities/comment_entity.dart';
import 'package:kanbanboard/domain/entities/update_task_entity.dart';
import 'package:kanbanboard/domain/repo_interfaces/i_board_repo.dart';
import 'package:kanbanboard/domain/use_cases/add_comment_usecase.dart';
import 'package:kanbanboard/domain/use_cases/update_tasks_usecase.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_event.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_state.dart';
import 'package:kanbanboard/view/board_view/model/card_item_data.dart';

import '../../board_view/kanban_board_view.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final IBoardRepo boardRepo;
  Timer? _timer;
  Timer? _saveTimer;
  Duration _elapsedTime = Duration.zero;
  CardBloc(CardItemData card, this.boardRepo) : super(NormalState(card: card)) {
    on<EditCardEvent>(_editCard);
    on<StartTimerEvent>(_startTimer);
    on<StopTimerEvent>(_stopTimer);
    on<TimerTickEvent>(_timerTick);
    on<AddCommentEvent>(_addComment);
  }

  _editCard(EditCardEvent event, Emitter<CardState> emit) async {
    if (state is EditState) {
      if (event.editedCard != null) {
        await _updateTask(UpdateTaskEntity(
            taskId: (state as EditState).card.id,
            title: event.editedCard!.task.description,
            sectionId: event.editedCard!.task.sectionId));
      }
      emit(NormalState(
          card: (state as EditState).card.copyWith(
              task: (state as EditState).card.task.copyWith(editMode: false))));
    } else {
      emit(EditState(
          card: (state as NormalState).card.copyWith(
              task:
                  (state as NormalState).card.task.copyWith(editMode: false))));
    }
  }

  _startTimer(StartTimerEvent event, Emitter<CardState> emit) {
    try {
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
      _elapsedTime = state.elapsedTime;
      emit(_mapToState(state, isRunning: true));
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _elapsedTime += const Duration(seconds: 1);
        add(TimerTickEvent(event.card));
      });

      _saveTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
        try {
          await _updateTask(UpdateTaskEntity(
              taskId: event.card.id, duration: _elapsedTime.inMinutes));
        } catch (error) {
          D.info("Failed to save timer duration: $error");
        }
      });
    } catch (e) {
      D.info("Failed to taske timer duration: $e");
    }
  }

  _stopTimer(StopTimerEvent event, Emitter<CardState> emit) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _saveTimer?.cancel();
    }

    _updateTask(UpdateTaskEntity(
        taskId: event.card.id, duration: _elapsedTime.inMinutes));
    emit(_mapToState(state, isRunning: false));
  }

  _timerTick(TimerTickEvent event, Emitter<CardState> emit) {
    emit(_mapToState(state, elapsedTime: _elapsedTime));
  }

  CardState _mapToState(CardState state,
      {bool? isRunning, Duration? elapsedTime}) {
    if (state is NormalState) {
      return NormalState(
        card: state.card,
        isRunning: isRunning ?? state.isRunning,
        elapsedTime: elapsedTime ?? state.elapsedTime,
      );
    } else if (state is EditState) {
      return EditState(
        card: state.card,
        isRunning: isRunning ?? state.isRunning,
        elapsedTime: elapsedTime ?? state.elapsedTime,
      );
    } else {
      return state;
    }
  }

  _updateTask(UpdateTaskEntity params) async {
    await UpdateTasksUseCase(boardRepo).call(params);
  }

  _addComment(AddCommentEvent event, Emitter<CardState> emit) async {
    await AddCommentUseCase(boardRepo).call(event.commentEntity);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _saveTimer?.cancel();
    return super.close();
  }
}
