// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:beauty_tracker/pages/login_page.dart' as _i8;
import 'package:beauty_tracker/pages/main_navigation/root_navigation_page.dart'
    as _i12;
import 'package:beauty_tracker/pages/main_navigation/tabs/analytics_page.dart'
    as _i2;
import 'package:beauty_tracker/pages/main_navigation/tabs/expiring_soon_page.dart'
    as _i6;
import 'package:beauty_tracker/pages/main_navigation/tabs/home_page.dart'
    as _i7;
import 'package:beauty_tracker/pages/main_navigation/tabs/profile_page.dart'
    as _i10;
import 'package:beauty_tracker/pages/onboarding_page.dart' as _i9;
import 'package:beauty_tracker/pages/product/add_product_page.dart' as _i1;
import 'package:beauty_tracker/pages/product/edit_product_page.dart' as _i5;
import 'package:beauty_tracker/pages/register_page.dart' as _i11;
import 'package:beauty_tracker/pages/settings/brand_settings_page.dart' as _i3;
import 'package:beauty_tracker/pages/settings/category_settings_page.dart'
    as _i4;
import 'package:flutter/material.dart' as _i14;

/// generated route for
/// [_i1.AddProductPage]
class AddProductRoute extends _i13.PageRouteInfo<AddProductRouteArgs> {
  AddProductRoute({_i14.Key? key, List<_i13.PageRouteInfo>? children})
    : super(
        AddProductRoute.name,
        args: AddProductRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'AddProductRoute';

  static _i13.PageInfo page = _i13.PageInfo(
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

  final _i14.Key? key;

  @override
  String toString() {
    return 'AddProductRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.AnalyticsPage]
class AnalyticsRoute extends _i13.PageRouteInfo<void> {
  const AnalyticsRoute({List<_i13.PageRouteInfo>? children})
    : super(AnalyticsRoute.name, initialChildren: children);

  static const String name = 'AnalyticsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.AnalyticsPage();
    },
  );
}

/// generated route for
/// [_i3.BrandSettingsPage]
class BrandSettingsRoute extends _i13.PageRouteInfo<void> {
  const BrandSettingsRoute({List<_i13.PageRouteInfo>? children})
    : super(BrandSettingsRoute.name, initialChildren: children);

  static const String name = 'BrandSettingsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.BrandSettingsPage();
    },
  );
}

/// generated route for
/// [_i4.CategorySettingsPage]
class CategorySettingsRoute extends _i13.PageRouteInfo<void> {
  const CategorySettingsRoute({List<_i13.PageRouteInfo>? children})
    : super(CategorySettingsRoute.name, initialChildren: children);

  static const String name = 'CategorySettingsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.CategorySettingsPage();
    },
  );
}

/// generated route for
/// [_i5.EditProductPage]
class EditProductRoute extends _i13.PageRouteInfo<EditProductRouteArgs> {
  EditProductRoute({
    _i14.Key? key,
    String? productId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         EditProductRoute.name,
         args: EditProductRouteArgs(key: key, productId: productId),
         rawPathParams: {'productId': productId},
         initialChildren: children,
       );

  static const String name = 'EditProductRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EditProductRouteArgs>(
        orElse:
            () => EditProductRouteArgs(
              productId: pathParams.optString('productId'),
            ),
      );
      return _i5.EditProductPage(key: args.key, productId: args.productId);
    },
  );
}

class EditProductRouteArgs {
  const EditProductRouteArgs({this.key, this.productId});

  final _i14.Key? key;

  final String? productId;

  @override
  String toString() {
    return 'EditProductRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i6.ExpiringSoonPage]
class ExpiringSoonRoute extends _i13.PageRouteInfo<void> {
  const ExpiringSoonRoute({List<_i13.PageRouteInfo>? children})
    : super(ExpiringSoonRoute.name, initialChildren: children);

  static const String name = 'ExpiringSoonRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.ExpiringSoonPage();
    },
  );
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomePage();
    },
  );
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i14.Key? key, List<_i13.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i8.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.OnboardingPage]
class OnboardingRoute extends _i13.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({_i14.Key? key, List<_i13.PageRouteInfo>? children})
    : super(
        OnboardingRoute.name,
        args: OnboardingRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'OnboardingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>(
        orElse: () => const OnboardingRouteArgs(),
      );
      return _i9.OnboardingPage(key: args.key);
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'OnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.ProfilePage]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute({List<_i13.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfilePage();
    },
  );
}

/// generated route for
/// [_i11.RegisterPage]
class RegisterRoute extends _i13.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({_i14.Key? key, List<_i13.PageRouteInfo>? children})
    : super(
        RegisterRoute.name,
        args: RegisterRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'RegisterRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
        orElse: () => const RegisterRouteArgs(),
      );
      return _i11.RegisterPage(key: args.key);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.RootNavigationPage]
class RootNavigationRoute extends _i13.PageRouteInfo<void> {
  const RootNavigationRoute({List<_i13.PageRouteInfo>? children})
    : super(RootNavigationRoute.name, initialChildren: children);

  static const String name = 'RootNavigationRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.RootNavigationPage();
    },
  );
}
