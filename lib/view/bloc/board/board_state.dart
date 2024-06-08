import 'package:appflowy_board/appflowy_board.dart';
import 'package:equatable/equatable.dart';
import 'package:kanbanboard/data/models/section.dart';

import '../../../data/models/task.dart';

abstract class BoardState extends Equatable {
  const BoardState();

  @override
  List<Object> get props => [];
}

class BoardInitial extends BoardState {}

class BoardLoading extends BoardState {
  final List<Section> sections;
  const BoardLoading({required this.sections});
}

class BoardLoaded extends BoardState {
  final List<Task> tasks;
  final List<Section> sections;
  final Map<String, List<Task>> taskGroupBySectionId;
  final List<AppFlowyGroupData> groups;
  final Task? newlyAddedTask  ;
  const BoardLoaded({
    required this.tasks,
    required this.sections,
    this.newlyAddedTask,
    required this.groups,
    required this.taskGroupBySectionId,
  });

  @override
  List<Object> get props => [tasks, sections, taskGroupBySectionId];
}




class BoardError extends BoardState {
  final String message;

  const BoardError(this.message);

  @override
  List<Object> get props => [message];
}
