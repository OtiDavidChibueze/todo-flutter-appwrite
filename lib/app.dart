import 'package:flutter/material.dart';
import 'package:todo_flutter_appwrite/core/common/theme/app_theme.dart';
import 'package:todo_flutter_appwrite/core/router/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dartThemeMode,
      title: 'Todo App',
      routerConfig: AppRoutes.routes,
    );
  }
}
