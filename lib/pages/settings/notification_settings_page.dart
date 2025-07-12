import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScrollView(
      header: [
        AppTitleBar(
          title: '通知設定',
          backButtonEnabled: true,
        )
      ],
      slivers: [
        SliverToBoxAdapter(
            child: Column(
          children: [
            AppElevatedButton(
              text: '保存設定',
              isFilled: true,
              onPressed: () {},
            )
          ],
        )),
      ],
    );
  }
}
