import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/menu/app_menu_group.dart';
import 'package:beauty_tracker/widgets/common/menu/app_menu_item.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:beauty_tracker/widgets/profile/settings/setting_section.dart';
import 'package:beauty_tracker/widgets/profile/user_avatar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = useDi<AuthService>();

    final user = authService.currentUser!;

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
              const SizedBox(height: 32),
              SettingSection(
                title: '帳號設定',
                children: [
                  AppMenuGroup(
                    items: [
                      AppMenuItem(
                        title: '修改密碼',
                        icon: Icons.lock,
                        onTap: () {},
                      ),
                      AppMenuItem(
                        title: '通知設定',
                        icon: Icons.email,
                        onTap: () {},
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
                        onTap: () {},
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
