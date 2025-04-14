import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EmailFormField extends HookWidget {
  const EmailFormField({
    super.key,
    this.labelText = '電子郵件',
    this.hintText = '輸入您的電子郵件',
    this.validator,
  });

  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(Icons.email_outlined),
        prefixIconColor: WidgetStateColor.resolveWith(
          (states) =>
              states.contains(WidgetState.focused) ? Theme.of(context).primaryColor : Colors.grey,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validator,
    );
  }
}
