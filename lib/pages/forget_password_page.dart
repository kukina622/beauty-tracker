import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/messages/auth_error_messages.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_easy_loading.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/util/email.dart';
import 'package:beauty_tracker/widgets/common/app_logo.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/form/email_form_field.dart';
import 'package:beauty_tracker/widgets/form/otp_form_field.dart';
import 'package:beauty_tracker/widgets/form/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class ForgetPasswordPage extends HookWidget {
  ForgetPasswordPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final currentStep = useState(0);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final otpValue = useState('');
    final easyLoading = useEasyLoading();
    final authService = useDi<AuthService>();

    final sendResetEmail = useCallback((String email) async {
      easyLoading.show(status: '發送驗證碼中...');

      final result = await authService.resetPassword(email).whenComplete(() {
        easyLoading.dismiss();
      });

      switch (result) {
        case Ok():
          if (context.mounted) {
            easyLoading.showSuccess('驗證碼已發送至您的電子郵件');
            currentStep.value = 1;
          }
          break;
        case Err():
          easyLoading.showError('發送失敗，請檢查電子郵件是否正確');
          break;
      }
    }, [easyLoading, authService]);

    final verifyOtp = useCallback((String email, String otp) async {
      easyLoading.show(status: '驗證中...');

      final result = await authService.verifyRecoveryOtp(email, otp).whenComplete(() {
        easyLoading.dismiss();
      });

      switch (result) {
        case Ok():
          if (context.mounted) {
            easyLoading.showSuccess('驗證成功');
            currentStep.value = 2;
          }
          break;
        case Err():
          easyLoading.showError('驗證碼錯誤，請重新輸入');
          break;
      }
    }, [easyLoading, authService]);

    final updatePassword = useCallback((String newPassword) async {
      easyLoading.show(status: '更新密碼中...');

      final result = await authService.updateForgotPassword(newPassword).whenComplete(() {
        easyLoading.dismiss();
      });

      switch (result) {
        case Ok():
          if (context.mounted) {
            easyLoading.showSuccess('密碼重設成功');
            AutoRouter.of(context).pushPath('/login');
          }
          break;
        case Err(error: final error):
          final message = authErrorMessages[error.code] ?? '密碼重設失敗';
          easyLoading.showError(message);
          break;
      }
    }, [easyLoading, authService]);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (currentStep.value > 0) {
              currentStep.value = currentStep.value - 1;
            } else {
              AutoRouter.of(context).pop();
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(child: AppLogo()),
                const SizedBox(height: 40),
                if (currentStep.value == 0) ...[
                  Text(
                    '忘記密碼',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '請輸入您的電子郵件地址，我們將發送驗證碼給您',
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
                          controller: emailController,
                          validator: (value) {
                            if (!isEmailValid(value)) {
                              return '請輸入有效的電子郵件地址';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        AppElevatedButton(
                          text: '發送驗證碼',
                          onPressed: () {
                            final bool isFormValid = _formKey.currentState?.validate() ?? false;
                            if (isFormValid) {
                              sendResetEmail(emailController.text);
                            }
                          },
                          isFilled: true,
                        ),
                      ],
                    ),
                  ),
                ] else if (currentStep.value == 1) ...[
                  Text(
                    '輸入驗證碼',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '我們已發送6位數驗證碼至 ${emailController.text}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 32),
                  OtpFormField(
                    onChanged: (value) {
                      otpValue.value = value;
                    },
                    validator: (value) {
                      if (value == null || value.length != 6) {
                        return '請輸入6位數驗證碼';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  AppElevatedButton(
                    text: '驗證',
                    onPressed: () {
                      if (otpValue.value.length == 6) {
                        verifyOtp(emailController.text, otpValue.value);
                      }
                    },
                    isFilled: true,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        sendResetEmail(emailController.text);
                      },
                      child: const Text(
                        '重新發送驗證碼',
                        style: TextStyle(
                          color: Color(0xFFFF9A9E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ] else if (currentStep.value == 2) ...[
                  Text(
                    '設定新密碼',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '請輸入您的新密碼',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        PasswordFormField(
                          controller: passwordController,
                          labelText: '新密碼',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '請輸入新密碼';
                            }
                            if (value.length < 6) {
                              return '密碼必須至少包含6個字';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        PasswordFormField(
                          controller: confirmPasswordController,
                          labelText: '確認新密碼',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '請確認您的新密碼';
                            }
                            if (value != passwordController.text) {
                              return '密碼不一致';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        AppElevatedButton(
                          text: '重設密碼',
                          onPressed: () {
                            final bool isFormValid = _formKey.currentState?.validate() ?? false;
                            if (isFormValid) {
                              updatePassword(passwordController.text);
                            }
                          },
                          isFilled: true,
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                if (currentStep.value == 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '想起密碼了嗎？',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).pop();
                        },
                        child: const Text(
                          '返回登入',
                          style: TextStyle(
                            color: Color(0xFFFF9A9E),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
