import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:beauty_tracker/widgets/profile/settings/notification_switch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class NotificationSettingsPage extends HookWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final thirtyNotificationEnabled = useState(true);
    final sevenNotificationEnabled = useState(true);
    final todayNotificationEnabled = useState(true);

    return Scaffold(
      body: PageScrollView(
        header: [
          AppTitleBar(
            title: '通知設定',
            backButtonEnabled: true,
          )
        ],
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '美妝品過期通知',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3142),
                  ),
                ),
                SizedBox(height: 12),
                NotificationSwitchCard(
                  title: '30日到期通知',
                  value: thirtyNotificationEnabled.value,
                  onChanged: (value) => thirtyNotificationEnabled.value = value,
                ),
                SizedBox(height: 16),
                NotificationSwitchCard(
                  title: '7日到期通知',
                  value: sevenNotificationEnabled.value,
                  onChanged: (value) => sevenNotificationEnabled.value = value,
                ),
                SizedBox(height: 16),
                NotificationSwitchCard(
                  title: '當日到期通知',
                  value: todayNotificationEnabled.value,
                  onChanged: (value) => todayNotificationEnabled.value = value,
                ),
                SizedBox(height: 20),
                AppElevatedButton(
                  text: '保存設定',
                  isFilled: true,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
