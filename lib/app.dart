import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/pages/todo.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login.dart';
import 'core/common/theme/app_theme.dart';
import 'core/router/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AuthGetLoggedInUser());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          AppRoutes.routes.goNamed(TodoPage.routeName);
        } else if (state is AuthErrorState) {
          AppRoutes.routes.goNamed(LoginPage.routeName);
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dartThemeMode,
        title: 'Todo App',
        routerConfig: AppRoutes.routes,
      ),
    );
  }
}
