import 'package:beauty_tracker/util/email.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EmailFormField extends HookWidget {
  const EmailFormField({
    super.key,
    this.labelText = '電子郵件',
    this.hintText = '輸入您的電子郵件',
    this.invalidEmailMessage = '請輸入有效的電子郵件',
    this.validator,
  });

  final String labelText;
  final String hintText;
  final String invalidEmailMessage;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return BaseFormField(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: const Icon(Icons.email_outlined),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (!isEmailValid(value)) {
          return invalidEmailMessage;
        }

        return validator?.call(value);
      },
    );
  }
}
