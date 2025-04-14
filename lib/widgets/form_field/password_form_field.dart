import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PasswordFormField extends HookWidget {
  const PasswordFormField({
    super.key,
    this.labelText = '密碼',
    this.hintText = '輸入您的密碼',
    this.validator,
  });

  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isVisiblePassword = useState(false);

    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: const Icon(Icons.lock_outline),
        prefixIconColor: WidgetStateColor.resolveWith(
          (states) =>
              states.contains(WidgetState.focused) ? Theme.of(context).primaryColor : Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisiblePassword.value ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            isVisiblePassword.value = !isVisiblePassword.value;
          },
        ),
      ),
      obscureText: !isVisiblePassword.value,
      validator: validator,
    );
  }
}
