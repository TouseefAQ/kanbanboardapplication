import 'package:appflowy_board/appflowy_board.dart';
import 'package:kanbanboard/application/core/extensions/extensions.dart';

import '../../../data/models/task.dart';

class CardItemData extends AppFlowyGroupItem {
  final Task task;

  CardItemData({required this.task});

  @override
  String get id => task.id!.asString;

  CardItemData copyWith({
    Task? task,
  }) {
    return CardItemData(
      task: task ?? this.task,
    );
  }
}
