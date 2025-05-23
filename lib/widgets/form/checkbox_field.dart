import 'package:flutter/material.dart';

class CheckboxField extends StatelessWidget {
  const CheckboxField({
    super.key,
    required this.label,
    this.value = false,
    this.onChanged,
  });

  final Widget label;
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            activeColor: const Color(0xFFFF9A9E),
            value: value,
            onChanged: (newValue) {
              onChanged?.call(newValue ?? false);
            },
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            onChanged?.call(!value);
          },
          child: label,
        ),
      ],
    );
  }
}
