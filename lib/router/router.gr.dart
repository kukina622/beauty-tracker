// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:beauty_tracker/pages/home_page.dart' as _i1;
import 'package:flutter/material.dart' as _i3;

/// generated route for
/// [_i1.MyHomePage]
class MyHomeRoute extends _i2.PageRouteInfo<MyHomeRouteArgs> {
  MyHomeRoute({
    _i3.Key? key,
    String title = 'Beauty Tracker',
    List<_i2.PageRouteInfo>? children,
  }) : super(
         MyHomeRoute.name,
         args: MyHomeRouteArgs(key: key, title: title),
         initialChildren: children,
       );

  static const String name = 'MyHomeRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyHomeRouteArgs>(
        orElse: () => const MyHomeRouteArgs(),
      );
      return _i1.MyHomePage(key: args.key, title: args.title);
    },
  );
}

class MyHomeRouteArgs {
  const MyHomeRouteArgs({this.key, this.title = 'Beauty Tracker'});

  final _i3.Key? key;

  final String title;

  @override
  String toString() {
    return 'MyHomeRouteArgs{key: $key, title: $title}';
  }
}
