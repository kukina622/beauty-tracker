import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/home', page: MyHomeRoute.page),
        AutoRoute(path: '/onboarding', page: OnboardingRoute.page, initial: true),
        AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(path: '/register', page: RegisterRoute.page),
      ];
}
