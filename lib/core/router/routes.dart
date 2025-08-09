import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/todo.dart';
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
    ],
    // errorPageBuilder: (context, state) => MaterialPage(child: SplashPage()),
  );
}
