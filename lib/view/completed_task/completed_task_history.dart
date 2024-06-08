import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbanboard/application/core/extensions/extensions.dart';
import 'package:kanbanboard/application/core/helpers/date_time_helper.dart';
import 'package:kanbanboard/application/core/logger/app_logging.dart';
import 'package:kanbanboard/view/bloc/board/board_bloc.dart';
import 'package:kanbanboard/view/bloc/board/board_state.dart';
import 'package:kanbanboard/application/constants/temp_data.dart';

import '../../data/models/task.dart';

class CompletedTaskHistory extends StatelessWidget {
  const CompletedTaskHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanban Board'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<BoardBloc, BoardState>(builder: (context, state) {
        D.info(
            'CompletedTaskHistory: ${state is BoardLoaded ? (state.taskGroupBySectionId[completedSection] ?? []).length : 0}');

        return ListView.builder(
            itemCount: state is BoardLoaded
                ? (state.taskGroupBySectionId[completedSection] ?? []).length
                : 0,
            itemBuilder: (_, index) {
              Task? task = state is BoardLoaded
                  ? (state.taskGroupBySectionId[completedSection] ?? [])[index]
                  : null;
              return ListTile(
                  title: Text(task!.description.asString),
                  subtitle: Text(
                    DateTimeHelper.formatDate(
                        DateTime.parse(task.createdAt.asString)),
                    style: context.textTheme.bodySmall,
                  ),
                  trailing: Text(DateTimeHelper.formatDurationFromInt(
                      task.duration?.amount ?? 0)));
            });
      }),
    );
  }
}
