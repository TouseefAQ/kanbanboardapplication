import 'package:appflowy_board/appflowy_board.dart';
import 'package:equatable/equatable.dart';
import 'package:kanbanboard/domain/entities/update_task_entity.dart';

abstract class BoardEvent extends Equatable {
  const BoardEvent();

  @override
  List<Object> get props => [];
}

class FetchTasks extends BoardEvent {}
class FetchSections extends BoardEvent {}
class CreateTaskEvent extends BoardEvent {
  final UpdateTaskEntity params ;
 final  AppFlowyBoardController controller ;
  const CreateTaskEvent(this.params,this.controller);
}
class MoveTask extends BoardEvent {
  final String fromSectionId;
  final int fromIndex;
  final String toSectionId;
  final int toIndex;
  final bool crossSection ;


  const MoveTask({
    required this.fromSectionId,
    required this.fromIndex,
    required this.crossSection,
    required this.toSectionId,
    required this.toIndex,
  });

  @override
  List<Object> get props => [fromSectionId, fromIndex, toSectionId, toIndex];
}

class GenerateGroups extends BoardEvent {}