import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BaseFormField extends HookWidget {
  const BaseFormField({
    super.key,
    this.labelText = '',
    this.hintText = '',
    this.prefixIcon,
    this.keyboardType,
    this.validator,
  });

  final String labelText;
  final String hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        prefixIconColor: WidgetStateColor.resolveWith(
          (states) =>
              states.contains(WidgetState.focused) ? Theme.of(context).primaryColor : Colors.grey,
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
