import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CheckboxField extends HookWidget {
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
    final ValueNotifier<bool> isChecked = useState(value);

    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            activeColor: const Color(0xFFFF9A9E),
            value: isChecked.value,
            onChanged: (value) {
              isChecked.value = value ?? false;
              onChanged?.call(isChecked.value);
            },
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            isChecked.value = !isChecked.value;
            onChanged?.call(isChecked.value);
          },
          child: label,
        ),
      ],
    );
  }
}
