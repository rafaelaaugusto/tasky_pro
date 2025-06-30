import 'package:flutter/material.dart';

import 'core/core.dart';
import 'features/tasks/tasks.dart';

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky Pro',
      theme: AppTheme.defaultTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const TasksPage(),
    );
  }
}
