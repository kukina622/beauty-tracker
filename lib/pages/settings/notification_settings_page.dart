import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_service.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:beauty_tracker/widgets/profile/settings/notification_switch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class NotificationSettingsPage extends HookWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorageService = useDi<LocalStorageService>();

    final loading = useState(true);
    final thirtyDayExpiryNotificationEnabled = useState(true);
    final sevenDayExpiryNotificationEnabled = useState(true);
    final todayExpiryNotificationEnabled = useState(true);

    useEffect(() {
      Future<void> loadSettings() async {
        thirtyDayExpiryNotificationEnabled.value = await localStorageService
                .getBool(LocalStorageKeys.thirtyDayExpiryNotificationEnabled) ??
            true;

        sevenDayExpiryNotificationEnabled.value =
            await localStorageService.getBool(LocalStorageKeys.sevenDayExpiryNotificationEnabled) ??
                true;

        todayExpiryNotificationEnabled.value =
            await localStorageService.getBool(LocalStorageKeys.todayExpiryNotificationEnabled) ??
                true;

        loading.value = false;
      }

      loadSettings();

      return null;
    }, []);

    useEffect(() {
      if (loading.value) {
        EasyLoading.show(
          status: '載入中...',
          maskType: EasyLoadingMaskType.black,
        );
      } else {
        EasyLoading.dismiss();
      }
      return null;
    }, [loading.value]);

    final onSaveSettings = useCallback(() async {
      await localStorageService.setBool(
        LocalStorageKeys.thirtyDayExpiryNotificationEnabled,
        thirtyDayExpiryNotificationEnabled.value,
      );

      await localStorageService.setBool(
        LocalStorageKeys.sevenDayExpiryNotificationEnabled,
        sevenDayExpiryNotificationEnabled.value,
      );

      await localStorageService.setBool(
        LocalStorageKeys.todayExpiryNotificationEnabled,
        todayExpiryNotificationEnabled.value,
      );

      EasyLoading.showSuccess('設定已保存', maskType: EasyLoadingMaskType.black);

      if (context.mounted) {
        AutoRouter.of(context).pop();
      }
    }, [
      localStorageService,
      thirtyDayExpiryNotificationEnabled,
      sevenDayExpiryNotificationEnabled,
      todayExpiryNotificationEnabled,
    ]);

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
                  value: thirtyDayExpiryNotificationEnabled.value,
                  onChanged: (value) => thirtyDayExpiryNotificationEnabled.value = value,
                ),
                SizedBox(height: 16),
                NotificationSwitchCard(
                  title: '7日到期通知',
                  value: sevenDayExpiryNotificationEnabled.value,
                  onChanged: (value) => sevenDayExpiryNotificationEnabled.value = value,
                ),
                SizedBox(height: 16),
                NotificationSwitchCard(
                  title: '當日到期通知',
                  value: todayExpiryNotificationEnabled.value,
                  onChanged: (value) => todayExpiryNotificationEnabled.value = value,
                ),
                SizedBox(height: 20),
                AppElevatedButton(
                  text: '保存設定',
                  isFilled: true,
                  onPressed: onSaveSettings,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
