import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/router/guards/auth_check_guard.dart';
import 'package:beauty_tracker/router/guards/first_visit_guard.dart';
import 'package:beauty_tracker/router/router.gr.dart';
import 'package:flutter/material.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          guards: [FirstVisitGuard(), AuthCheckGuard()],
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(path: '/onboarding', page: OnboardingRoute.page),
        CustomRoute<dynamic>(
          path: '/login',
          page: LoginRoute.page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          duration: Duration(milliseconds: 300),
        ),
        CustomRoute<dynamic>(
          path: '/register',
          page: RegisterRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeft,
          duration: Duration(milliseconds: 300),
        ),
      ];
}
