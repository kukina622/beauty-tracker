import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_easy_loading.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/form/password_form_field.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class ChangePasswordSettingsPage extends HookWidget {
  const ChangePasswordSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final authService = useDi<AuthService>();
    final easyLoading = useEasyLoading();

    final oldPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final onSubmit = useCallback(() async {
      final isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }
      final oldPassword = oldPasswordController.text.trim();
      final newPassword = newPasswordController.text.trim();

      easyLoading.show(status: '處理中...');
      final result = await authService.changePassword(oldPassword, newPassword).whenComplete(() {
        easyLoading.dismiss();
      });

      switch (result) {
        case Ok():
          easyLoading.showSuccess('密碼修改成功');
          if (context.mounted) {
            AutoRouter.of(context).pop();
          }
          break;
        case Err():
          easyLoading.showError('密碼修改失敗');
          break;
      }
    }, [
      formKey,
      oldPasswordController,
      newPasswordController,
      authService,
    ]);

    return Scaffold(
      body: PageScrollView(
        header: [
          AppTitleBar(
            title: '修改密碼',
            backButtonEnabled: true,
          )
        ],
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  PasswordFormField(
                    labelText: '舊密碼',
                    hintText: '輸入您的舊密碼',
                    controller: oldPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請輸入舊密碼';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  PasswordFormField(
                    labelText: '新密碼',
                    hintText: '輸入您的新密碼',
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請輸入新密碼';
                      }
                      if (value.length < 6) {
                        return '新密碼必須至少包含6個字';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  PasswordFormField(
                    labelText: '確認新密碼',
                    hintText: '再次輸入您的新密碼',
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value != newPasswordController.text) {
                        return '兩次輸入的密碼不一致';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  AppElevatedButton(
                    text: '修改密碼',
                    onPressed: onSubmit,
                    isFilled: true,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
