import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbanboard/application/constants/dimension_constants.dart';
import 'package:kanbanboard/application/core/extensions/extensions.dart';
import 'package:kanbanboard/application/core/helpers/date_time_helper.dart';
import 'package:kanbanboard/application/services/nav_service/i_navigation_service.dart';
import 'package:kanbanboard/di/di.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_bloc.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_event.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_state.dart';
import 'package:kanbanboard/view/board_view/kanban_board_view.dart';
import 'package:kanbanboard/view/board_view/model/card_item_data.dart';
import 'package:kanbanboard/view/board_view/widgets/comment_sheet.dart';

class RichTextCard extends StatefulWidget {
  final CardItemData item;
  final AppFlowyBoardController controller;
  const RichTextCard({
    required this.item,
    required this.controller,
    super.key,
  });

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  late TextEditingController controller =
      TextEditingController(text: widget.item.task.description);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardBloc>(
      create: (BuildContext context) => CardBloc(widget.item, inject()),
      child: BlocBuilder<CardBloc, CardState>(builder: (context, state) {
        if (state is NormalState) {}

        return Container(
            padding: const EdgeInsets.all(DimensionConstants.padding8),
            decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(DimensionConstants.padding8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: (state is NormalState)
                            ? Text(
                                widget.item.task.description.asString,
                                style: context.textTheme.bodyMedium,
                                textAlign: TextAlign.left,
                                // maxLines: 2,
                              )
                            : TextField(
                                controller: controller,
                                onSubmitted: (val) {},
                              )),
                    if (state is NormalState)
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CardBloc>()
                              .add(EditCardEvent(widget.item));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(DimensionConstants.padding4),
                          child: Icon(
                            Icons.edit,
                            size: 16,
                          ),
                        ),
                      ),
                    if (state is EditState)
                      TextButton(
                          onPressed: () {
                            context.read<CardBloc>().add(EditCardEvent(
                                widget.item,
                                editedCard: state.card.copyWith(
                                    task: state.card.task.copyWith(
                                        description: controller.text))));

                            widget.controller.updateGroupItem(
                                widget.item.task.sectionId.asString,
                                state.card.copyWith(
                                    task: state.card.task.copyWith(
                                        description: controller.text)));
                          },
                          child: const Text("save"))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (state.isRunning) {
                              context
                                  .read<CardBloc>()
                                  .add(StopTimerEvent(widget.item));
                            } else {
                              context
                                  .read<CardBloc>()
                                  .add(StartTimerEvent(widget.item));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4, right: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.stop_circle,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                Text(
                                  state.elapsedTime.inSeconds <= 0
                                      ? "Track Time"
                                      : DateTimeHelper.formatDuration(
                                          state.elapsedTime),
                                  style: context.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                            DateTimeHelper.formatDate(DateTime.parse(
                                widget.item.task.createdAt.asString)),
                            style: context.textTheme.bodySmall),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        inject<INavigationService>()
                            .showBottomSheet(CommentBottomSheet(
                          item: widget.item,
                          controller: widget.controller,
                          bloc: context.read<CardBloc>(),
                        ));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.all(DimensionConstants.padding4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.comment,
                              size: 16,
                            ),
                            const SizedBox(width: 2),
                            if (widget.item.task.commentCount.asNum > 0)
                              Text("${widget.item.task.commentCount}",
                                  style: context.textTheme.bodySmall),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ));
      }),
    );
  }
}
