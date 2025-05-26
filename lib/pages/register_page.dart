import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/messages/auth_error_messages.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/widgets/form/email_form_field.dart';
import 'package:beauty_tracker/widgets/form/password_form_field.dart';
import 'package:beauty_tracker/widgets/social_login/google_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:watch_it/watch_it.dart';

@RoutePage()
class RegisterPage extends WatchingWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();

  Future<void> signUpWithEmail(BuildContext context, String email, String password) async {
    EasyLoading.show(status: '註冊中...', maskType: EasyLoadingMaskType.black);

    final result = await di<AuthService>().signUpWithEmail(email, password).whenComplete(() {
      EasyLoading.dismiss();
    });
    switch (result) {
      case Ok():
        if (context.mounted) {
          EasyLoading.showSuccess('註冊成功', maskType: EasyLoadingMaskType.black);
          AutoRouter.of(context).replacePath('/');
        }
        break;
      case Err():
        final String message = authErrorMessages[result.error.code] ?? '註冊失敗';
        EasyLoading.showError(message, maskType: EasyLoadingMaskType.black);
        break;
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final result = await di<AuthService>().signInWithGoogle();

    switch (result) {
      case Ok():
        if (context.mounted) {
          EasyLoading.showSuccess('登入成功', maskType: EasyLoadingMaskType.black);
          AutoRouter.of(context).replacePath('/');
        }
        break;
      case Err():
        EasyLoading.showError('登入失敗', maskType: EasyLoadingMaskType.black);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HookBuilder(builder: (context) {
      final emailController = useTextEditingController();
      final passwordController = useTextEditingController();
      final confirmPasswordController = useTextEditingController();

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    '創建帳戶',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '請填寫以下資料完成註冊',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        EmailFormField(
                          labelText: '電子郵件',
                          hintText: '請輸入您的電子郵件',
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                        PasswordFormField(
                          labelText: '密碼',
                          hintText: '請輸入密碼',
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '請輸入密碼';
                            }
                            if (value.length < 6) {
                              return '密碼必須至少包含6個字';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        PasswordFormField(
                          labelText: '確認密碼',
                          hintText: '請再次輸入密碼',
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '請再次輸入密碼';
                            }
                            if (value != passwordController.text) {
                              return '兩次輸入的密碼不一致';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              final bool isFormValid = _formKey.currentState?.validate() ?? false;

                              if (isFormValid) {
                                signUpWithEmail(
                                  context,
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF9A9E),
                              disabledBackgroundColor: Colors.grey.shade300,
                            ),
                            child: const Text('註冊'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '或使用以下方式註冊',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: GoogleLogin(onPressed: () => signInWithGoogle(context)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '已有帳戶？',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).maybePop();
                        },
                        child: const Text(
                          '立即登入',
                          style: TextStyle(
                            color: Color(0xFFFF9A9E),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
