import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter_appwrite/features/todo/presentation/pages/add_todo.dart';
import 'package:todo_flutter_appwrite/features/todo/presentation/pages/todo.dart';
import '../../features/auth/presentation/pages/login.dart';
import '../../features/auth/presentation/pages/register.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

final class AppRoutes {
  static final GoRouter routes = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: SplashPage.routeName,
        builder: (context, state) => SplashPage(),
      ),

      GoRoute(
        path: '/register',
        name: RegisterPage.routeName,
        builder: (context, state) => RegisterPage(),
      ),

      GoRoute(
        path: '/login',
        name: LoginPage.routeName,
        builder: (context, state) => LoginPage(),
      ),

      GoRoute(
        path: '/todo',
        name: TodoPage.routeName,
        builder: (context, state) => TodoPage(),
      ),

      GoRoute(
        path: '/add-todo',
        name: AddTodo.routeName,
        builder: (context, state) => AddTodo(),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(child: SplashPage()),
  );
}
