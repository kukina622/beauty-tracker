import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/widgets/category/category_filter.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/home/expiring_soon_tile.dart';
import 'package:beauty_tracker/widgets/home/notification_button.dart';
import 'package:beauty_tracker/widgets/home/sub_title_bar.dart';
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
          actionButton: NotificationButton(),
        ),
      ],
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ExpiringSoonTile(),
              const SizedBox(height: 24),
              SubTitleBar(title: '所有分類'),
              SizedBox(height: 14),
              CategoryFilter(),
              const SizedBox(height: 18),
              SubTitleBar(title: '保養品', enableAddOption: false),
            ],
          ),
        )
      ],
    );
  }
}
