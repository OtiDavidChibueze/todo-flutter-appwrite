import 'package:go_router/go_router.dart';
import 'package:todo_flutter_appwrite/features/splash/presentation/pages/splash_page.dart';

final class AppRoutes {
  static final GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: SplashPage.routeName,
        builder: (context, state) => SplashPage(),
      ),
    ],
  );
}
