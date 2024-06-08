import 'package:kanbanboard/domain/entities/comment_entity.dart';
import 'package:kanbanboard/view/board_view/kanban_board_view.dart';
import 'package:kanbanboard/view/board_view/model/card_item_data.dart';

abstract class CardEvent {}

class EditCardEvent extends CardEvent {
  final CardItemData card;
  final CardItemData? editedCard;
  EditCardEvent(this.card, {this.editedCard});
}

class StartTimerEvent extends CardEvent {
  final CardItemData card;
  StartTimerEvent(this.card);
}

class StopTimerEvent extends CardEvent {
  final CardItemData card;
  StopTimerEvent(this.card);
}

class TimerTickEvent extends CardEvent {
  final CardItemData card;
  TimerTickEvent(this.card);
}

class AddCommentEvent extends CardEvent {
  final CommentEntity commentEntity;
  AddCommentEvent(this.commentEntity);
}
