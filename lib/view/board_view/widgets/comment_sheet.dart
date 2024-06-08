import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:kanbanboard/application/constants/app_constants.dart';
import 'package:kanbanboard/application/constants/dimension_constants.dart';
import 'package:kanbanboard/application/core/extensions/extensions.dart';
import 'package:kanbanboard/domain/entities/comment_entity.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_bloc.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_event.dart';
import 'package:kanbanboard/view/board_view/model/card_item_data.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet(
      {super.key,
        required this.item,
        required this.bloc,
        required this.controller});
  final CardItemData item;
  final CardBloc bloc;
  final AppFlowyBoardController controller;
  @override
  CommentBottomSheetState createState() => CommentBottomSheetState();
}

class CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  OutlineInputBorder get border => OutlineInputBorder(
      borderSide: BorderSide(color: context.primaryColor),
      borderRadius: BorderRadius.circular(DimensionConstants.padding12));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Enter your comment',
              border: border,
              focusedBorder: border,
              enabledBorder: border,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final comment = _commentController.text;
              widget.bloc.add(AddCommentEvent(CommentEntity(
                  taskId: widget.item.task.id.asString,
                  comment: comment,
                  projectId: AppConstants.projectId)));
              widget.controller.updateGroupItem(
                  widget.item.task.sectionId.asString,
                  widget.item.copyWith(
                      task: widget.item.task.copyWith(
                          commentCount:
                          (widget.item.task.commentCount ?? 0) + 1)));
              Navigator.pop(context); // Close the bottom sheet
            },
            child: Text(
              'Save',
              style: context.textTheme.headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
