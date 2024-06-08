import 'package:equatable/equatable.dart';
import 'package:kanbanboard/view/board_view/kanban_board_view.dart';
import 'package:kanbanboard/view/board_view/model/card_item_data.dart';

abstract class CardState {
  final CardItemData card;
  final bool isRunning;
  final Duration elapsedTime;

  CardState({
    required this.card,
    this.isRunning = false,
    this.elapsedTime = Duration.zero,
  });
}

class NormalState extends CardState {
  NormalState({
    required super.card,
    super.isRunning,
    super.elapsedTime,
  });
}

class EditState extends CardState {
  EditState({
    required super.card,
    super.isRunning,
    super.elapsedTime,
  });
}

