import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbanboard/application/constants/app_constants.dart';
import 'package:kanbanboard/application/core/theme/app_theme.dart';
import 'package:kanbanboard/application/services/nav_service/i_navigation_service.dart';
import 'package:kanbanboard/di/di.dart';
import 'package:kanbanboard/view/bloc/board/board_bloc.dart';
import 'package:kanbanboard/view/board_view/kanban_board_view.dart' hide HexColor;

import 'core/extensions/extensions.dart';
import 'core/theme/app_theme.dart';

class KanbanBoard extends StatelessWidget {
  const KanbanBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BoardBloc(boardRepo: inject(), prefService: inject()),
      child: MaterialApp(
          title: 'Kanban Board',
          navigatorKey: inject<INavigationService>().key(),
          theme: AppThemes.getTheme,
          home: const KanBanBoardView()),
    );
  }
}
