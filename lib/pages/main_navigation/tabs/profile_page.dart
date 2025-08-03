import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_easy_loading.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/menu/app_menu_group.dart';
import 'package:beauty_tracker/widgets/common/menu/app_menu_item.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:beauty_tracker/widgets/profile/logout_dialog.dart';
import 'package:beauty_tracker/widgets/profile/settings/setting_section.dart';
import 'package:beauty_tracker/widgets/profile/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class ProfilePage extends HookWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = useDi<AuthService>();
    final easyLoading = useEasyLoading();

    final user = authService.currentUser!;

    final onLogout = useCallback(() async {
      easyLoading.show(status: '登出中...');
      final result = await authService.signOut().whenComplete(() {
        easyLoading.dismiss();
      });

      switch (result) {
        case Ok():
          easyLoading.showSuccess('登出成功');
          if (context.mounted) {
            AutoRouter.of(context).replacePath('/login');
          }
          break;
        case Err():
          easyLoading.showError('登出失敗');
          break;
      }
    }, [authService, context]);

    return PageScrollView(
      header: [
        AppTitleBar(title: '個人資料'),
      ],
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              UserAvatar(),
              const SizedBox(height: 12),
              Text(
                user.name ?? '未命名',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 16),
              SettingSection(
                title: '帳號設定',
                children: [
                  AppMenuGroup(
                    items: [
                      AppMenuItem(
                        title: '修改密碼',
                        icon: Icons.lock,
                        onTap: () {
                          AutoRouter.of(context).pushPath('/settings/change-password');
                        },
                      ),
                      AppMenuItem(
                        title: '通知設定',
                        icon: Icons.email,
                        onTap: () {
                          AutoRouter.of(context).pushPath('/settings/notification-settings');
                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 12),
              SettingSection(
                title: '應用設定',
                children: [
                  AppMenuGroup(
                    items: [
                      AppMenuItem(
                        title: '品牌設定',
                        icon: Icons.workspace_premium_outlined,
                        onTap: () {
                          AutoRouter.of(context).pushPath('/settings/brand-settings');
                        },
                      ),
                      AppMenuItem(
                        title: '類別設定',
                        icon: Icons.category,
                        onTap: () {
                          AutoRouter.of(context).pushPath('/settings/category-settings');
                        },
                      ),
                    ],
                  )
                ],
              ),
              SettingSection(
                title: '',
                children: [
                  AppMenuGroup(
                    items: [
                      AppMenuItem(
                        title: '登出',
                        icon: Icons.logout,
                        textColor: const Color(0xFFFF6B6B),
                        onTap: () {
                          LogoutDialog.show(
                            context,
                            title: '登出確認',
                            description: '您確定要登出嗎？',
                            onConfirm: onLogout,
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 80),
        ),
      ],
    );
  }
}
