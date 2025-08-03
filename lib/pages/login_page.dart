import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_easy_loading.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_service.dart';
import 'package:beauty_tracker/util/email.dart';
import 'package:beauty_tracker/widgets/common/app_logo.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/form/checkbox_field.dart';
import 'package:beauty_tracker/widgets/form/email_form_field.dart';
import 'package:beauty_tracker/widgets/form/password_form_field.dart';
import 'package:beauty_tracker/widgets/social_login/google_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

@RoutePage()
class LoginPage extends HookWidget {
  LoginPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> rememberEmail(
    LocalStorageService localStorageService,
    String email,
    bool isRemember,
  ) async {
    if (isRemember) {
      await localStorageService.setString(LocalStorageKeys.userEmail, email);
    } else {
      await localStorageService.remove(LocalStorageKeys.userEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isRemember = useState(false);
    final easyLoading = useEasyLoading();

    final authService = useDi<AuthService>();
    final localStorageService = useDi<LocalStorageService>();

    final futureRemeberEmail = useMemoized(
      () => localStorageService.getString(LocalStorageKeys.userEmail),
      [localStorageService],
    );

    final snapshot = useFuture(futureRemeberEmail);

    useEffect(() {
      if (snapshot.connectionState == ConnectionState.done) {
        final email = snapshot.data;
        emailController.text = email ?? '';
        isRemember.value = (email != null);
      }
      return null;
    }, [snapshot.connectionState, snapshot.data]);

    final signInWithEmail = useCallback((String email, String password, bool isRemember) async {
      easyLoading.show(status: '登入中...');

      final result = await authService.signInWithEmail(email, password).whenComplete(() {
        easyLoading.dismiss();
      });

      switch (result) {
        case Ok():
          await rememberEmail(localStorageService, email, isRemember);

          if (context.mounted) {
            easyLoading.showSuccess('登入成功');
            AutoRouter.of(context).replacePath('/');
          }
          break;
        case Err():
          easyLoading.showError('帳號或密碼錯誤');
          break;
      }
    }, [easyLoading, authService, localStorageService]);

    final signInWithGoogle = useCallback(() async {
      final result = await authService.signInWithGoogle();

      switch (result) {
        case Ok():
          if (context.mounted) {
            easyLoading.showSuccess('登入成功');
            AutoRouter.of(context).replacePath('/');
          }
          break;
        case Err():
          easyLoading.showError('登入失敗');
          break;
      }
    }, [easyLoading, authService]);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(child: AppLogo()),
                const SizedBox(height: 40),
                Text(
                  '歡迎回來',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '請登入您的帳戶以繼續',
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
                            return '請輸入有效的電子郵件';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      PasswordFormField(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CheckboxField(
                            value: isRemember.value,
                            label: Text(
                              '記住我',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                              ),
                            ),
                            onChanged: (value) {
                              isRemember.value = value;
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              // 忘記密碼功能
                            },
                            child: const Text(
                              '忘記密碼？',
                              style: TextStyle(
                                color: Color(0xFFFF9A9E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      AppElevatedButton(
                        text: '登入',
                        onPressed: () {
                          final bool isFormValid = _formKey.currentState?.validate() ?? false;
                          if (isFormValid) {
                            signInWithEmail(
                              emailController.text,
                              passwordController.text,
                              isRemember.value,
                            );
                          }
                        },
                        isFilled: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '或使用以下方式登入',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GoogleLogin(onPressed: signInWithGoogle),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '還沒有帳戶？',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        AutoRouter.of(context).pushPath('/register');
                      },
                      child: const Text(
                        '立即註冊',
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
  }
}
