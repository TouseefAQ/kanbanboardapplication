import 'package:flutter/material.dart';
import 'package:kanbanboard/application/core/logger/app_logging.dart';
import 'package:logging/logging.dart';

import 'application/kanban_app.dart';
import 'application/main_config/main_config.dart';


Future<void> main() async {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    logHandler(record);
  });
  WidgetsFlutterBinding.ensureInitialized();
  await initMainServiceLocator();
  runApp(const KanbanBoard());
}
