import 'package:appflowy_board/appflowy_board.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbanboard/application/constants/app_constants.dart';
import 'package:kanbanboard/application/constants/dimension_constants.dart';
import 'package:kanbanboard/application/core/extensions/extensions.dart';
import 'package:kanbanboard/application/core/helpers/date_time_helper.dart';
import 'package:kanbanboard/application/core/logger/app_logging.dart';
import 'package:kanbanboard/application/services/nav_service/i_navigation_service.dart';
import 'package:kanbanboard/application/services/pref_service/i_pref_service.dart';
import 'package:kanbanboard/data/models/section.dart';
import 'package:kanbanboard/data/remote_data_src/i_board_api.dart';
import 'package:kanbanboard/domain/entities/comment_entity.dart';
import 'package:kanbanboard/domain/entities/update_task_entity.dart';
import 'package:kanbanboard/view/bloc/board/board_bloc.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_bloc.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_event.dart';
import 'package:kanbanboard/view/bloc/card_bloc/card_state.dart';

import '../../data/models/task.dart';
import '../../di/di.dart';
import '../bloc/board/board_event.dart';
import '../bloc/board/board_state.dart';
import '../completed_task/completed_task_history.dart';
import 'model/card_item_data.dart';
import 'widgets/board_card_item.dart';

class KanBanBoardView extends StatefulWidget {
  const KanBanBoardView({super.key});

  @override
  State<KanBanBoardView> createState() => _KanBanBoardViewState();
}

class _KanBanBoardViewState extends State<KanBanBoardView> {
  late final AppFlowyBoardController controller;

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    super.initState();
    boardController = AppFlowyBoardScrollController();
    controller = AppFlowyBoardController(
      onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        BlocProvider.of<BoardBloc>(context).add(MoveTask(
          fromSectionId: fromGroupId,
          crossSection: true,
          fromIndex: fromIndex,
          toSectionId: toGroupId,
          toIndex: toIndex,
        ));
      },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        BlocProvider.of<BoardBloc>(context).add(MoveTask(
          fromSectionId: groupId,
          fromIndex: fromIndex,
          crossSection: false,
          toSectionId: groupId,
          toIndex: toIndex,
        ));
      },
    );

    _fetchDataAndAddGroups();
  }

  Future<void> _fetchDataAndAddGroups() async {
    final boardBloc = BlocProvider.of<BoardBloc>(context);

    boardBloc.stream.listen((state) {
      if (state is BoardLoaded) {
        controller.clear();
        controller.addGroups(state.groups);
        if (state.newlyAddedTask != null) {
          controller.addGroupItem(state.newlyAddedTask!.sectionId.asString,
              CardItemData(task: state.newlyAddedTask!));
        }
      }
    });
    boardBloc.add(FetchTasks());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
      stretchGroupHeight: false,
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.list),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const CompletedTaskHistory()));
          },
          label: const Text("Completed Tasks"),
        ),
        appBar: AppBar(
          title: const Text('Kanban Board'),
        ),
        body: BlocBuilder<BoardBloc, BoardState>(
          builder: (context, state) {
            if (state is BoardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BoardError) {
              return Center(child: Text(state.message));
            } else if (state is BoardLoaded) {
              return AppFlowyBoard(
                controller: controller,
                cardBuilder: (context, group, groupItem) {
                  return AppFlowyGroupCard(
                    key: ValueKey(groupItem.id),
                    child: _buildCard(groupItem),
                  );
                },
                boardScrollController: boardController,
                footerBuilder: (context, columnData) {
                  return AppFlowyGroupFooter(
                    icon: const Icon(Icons.add, size: 20),
                    title: const Text('New'),
                    height: 50,
                    margin: config.groupBodyPadding,
                    onAddButtonClick: () {
                      context.read<BoardBloc>().add(CreateTaskEvent(
                          UpdateTaskEntity(sectionId: columnData.id),
                          controller));

                      boardController.scrollToBottom(columnData.id);
                    },
                  );
                },
                headerBuilder: (context, columnData) {
                  return AppFlowyGroupHeader(
                    icon: const Icon(Icons.lightbulb_circle),
                    title: Flexible(
                      child: Text(
                        columnData.headerData.groupName,
                        style: context.textTheme.headlineSmall,
                      ),
                    ),
                    // addIcon: const Icon(Icons.add, size: 20),
                    height: 50,
                    margin: config.groupBodyPadding,
                  );
                },
                groupConstraints: const BoxConstraints.tightFor(width: 240),
                config: config,
              );
            }
            return Container(); // Handle other states if necessary
          },
        ));
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is CardItemData) {
      return RichTextCard(
        item: item,
        controller: controller,
      );
    }

    throw UnimplementedError();
  }
}
