// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:beauty_tracker/pages/login_page.dart' as _i4;
import 'package:beauty_tracker/pages/main_navigation/root_navigation_page.dart'
    as _i7;
import 'package:beauty_tracker/pages/main_navigation/tabs/analytics_page.dart'
    as _i1;
import 'package:beauty_tracker/pages/main_navigation/tabs/expiring_soon_page.dart'
    as _i2;
import 'package:beauty_tracker/pages/main_navigation/tabs/home_page.dart'
    as _i3;
import 'package:beauty_tracker/pages/onboarding_page.dart' as _i5;
import 'package:beauty_tracker/pages/register_page.dart' as _i6;
import 'package:flutter/material.dart' as _i9;

/// generated route for
/// [_i1.AnalyticsPage]
class AnalyticsRoute extends _i8.PageRouteInfo<void> {
  const AnalyticsRoute({List<_i8.PageRouteInfo>? children})
    : super(AnalyticsRoute.name, initialChildren: children);

  static const String name = 'AnalyticsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.AnalyticsPage();
    },
  );
}

/// generated route for
/// [_i2.ExpiringSoonPage]
class ExpiringSoonRoute extends _i8.PageRouteInfo<void> {
  const ExpiringSoonRoute({List<_i8.PageRouteInfo>? children})
    : super(ExpiringSoonRoute.name, initialChildren: children);

  static const String name = 'ExpiringSoonRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.ExpiringSoonPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i9.Key? key, List<_i8.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i4.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.OnboardingPage]
class OnboardingRoute extends _i8.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({_i9.Key? key, List<_i8.PageRouteInfo>? children})
    : super(
        OnboardingRoute.name,
        args: OnboardingRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'OnboardingRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>(
        orElse: () => const OnboardingRouteArgs(),
      );
      return _i5.OnboardingPage(key: args.key);
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'OnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterRoute extends _i8.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({_i9.Key? key, List<_i8.PageRouteInfo>? children})
    : super(
        RegisterRoute.name,
        args: RegisterRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'RegisterRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
        orElse: () => const RegisterRouteArgs(),
      );
      return _i6.RegisterPage(key: args.key);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.RootNavigationPage]
class RootNavigationRoute extends _i8.PageRouteInfo<void> {
  const RootNavigationRoute({List<_i8.PageRouteInfo>? children})
    : super(RootNavigationRoute.name, initialChildren: children);

  static const String name = 'RootNavigationRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.RootNavigationPage();
    },
  );
}
