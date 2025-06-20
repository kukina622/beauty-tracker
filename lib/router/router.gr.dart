// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:beauty_tracker/pages/empty_router_page.dart' as _i3;
import 'package:beauty_tracker/pages/login_page.dart' as _i6;
import 'package:beauty_tracker/pages/main_navigation/root_navigation_page.dart'
    as _i9;
import 'package:beauty_tracker/pages/main_navigation/tabs/analytics_page.dart'
    as _i2;
import 'package:beauty_tracker/pages/main_navigation/tabs/expiring_soon_page.dart'
    as _i4;
import 'package:beauty_tracker/pages/main_navigation/tabs/home_page.dart'
    as _i5;
import 'package:beauty_tracker/pages/onboarding_page.dart' as _i7;
import 'package:beauty_tracker/pages/product/add_product_page.dart' as _i1;
import 'package:beauty_tracker/pages/register_page.dart' as _i8;
import 'package:flutter/material.dart' as _i11;

/// generated route for
/// [_i1.AddProductPage]
class AddProductRoute extends _i10.PageRouteInfo<AddProductRouteArgs> {
  AddProductRoute({_i11.Key? key, List<_i10.PageRouteInfo>? children})
    : super(
        AddProductRoute.name,
        args: AddProductRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'AddProductRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddProductRouteArgs>(
        orElse: () => const AddProductRouteArgs(),
      );
      return _i1.AddProductPage(key: args.key);
    },
  );
}

class AddProductRouteArgs {
  const AddProductRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'AddProductRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.AnalyticsPage]
class AnalyticsRoute extends _i10.PageRouteInfo<void> {
  const AnalyticsRoute({List<_i10.PageRouteInfo>? children})
    : super(AnalyticsRoute.name, initialChildren: children);

  static const String name = 'AnalyticsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.AnalyticsPage();
    },
  );
}

/// generated route for
/// [_i3.EmptyRouterPage]
class EmptyRouterRoute extends _i10.PageRouteInfo<void> {
  const EmptyRouterRoute({List<_i10.PageRouteInfo>? children})
    : super(EmptyRouterRoute.name, initialChildren: children);

  static const String name = 'EmptyRouterRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i3.EmptyRouterPage();
    },
  );
}

/// generated route for
/// [_i4.ExpiringSoonPage]
class ExpiringSoonRoute extends _i10.PageRouteInfo<void> {
  const ExpiringSoonRoute({List<_i10.PageRouteInfo>? children})
    : super(ExpiringSoonRoute.name, initialChildren: children);

  static const String name = 'ExpiringSoonRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.ExpiringSoonPage();
    },
  );
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomePage();
    },
  );
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i11.Key? key, List<_i10.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i6.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.OnboardingPage]
class OnboardingRoute extends _i10.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({_i11.Key? key, List<_i10.PageRouteInfo>? children})
    : super(
        OnboardingRoute.name,
        args: OnboardingRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'OnboardingRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>(
        orElse: () => const OnboardingRouteArgs(),
      );
      return _i7.OnboardingPage(key: args.key);
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'OnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.RegisterPage]
class RegisterRoute extends _i10.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({_i11.Key? key, List<_i10.PageRouteInfo>? children})
    : super(
        RegisterRoute.name,
        args: RegisterRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'RegisterRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
        orElse: () => const RegisterRouteArgs(),
      );
      return _i8.RegisterPage(key: args.key);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.RootNavigationPage]
class RootNavigationRoute extends _i10.PageRouteInfo<void> {
  const RootNavigationRoute({List<_i10.PageRouteInfo>? children})
    : super(RootNavigationRoute.name, initialChildren: children);

  static const String name = 'RootNavigationRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.RootNavigationPage();
    },
  );
}
