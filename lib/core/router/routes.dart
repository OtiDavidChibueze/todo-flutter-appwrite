import 'package:go_router/go_router.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/pages/login.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/pages/register.dart';
import 'package:todo_flutter_appwrite/features/splash/presentation/pages/splash_page.dart';

final class AppRoutes {
  static final GoRouter routes = GoRouter(
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
    ],
  );
}
