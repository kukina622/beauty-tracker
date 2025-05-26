import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/tabs/tab_page_scroll_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TabPageScrollView(
      header: [
        AppTitleBar(
          title: 'Beauty Tracker',
          subtitle: 'Track your beauty products',
        ),
      ],
      sliver: SliverToBoxAdapter(),
    );
  }
}
