import 'package:beauty_tracker/util/color.dart';
import 'package:beauty_tracker/widgets/common/dialog/color_picker/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ColorSelectorField extends HookWidget {
  const ColorSelectorField({
    super.key,
    this.initialColor = const Color(0xFFFF9A9E),
    this.onSelect,
    this.isEditing = false,
  });

  final Color? initialColor;
  final void Function(Color?)? onSelect;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState<Color?>(initialColor ?? const Color(0xFFFF9A9E));
    final hasSelectedColor = useState<bool>(isEditing);

    return GestureDetector(
      onTap: () async {
        final newColor = await ColorPicker.show(
          context,
          initialColor: selectedColor.value,
          allColors: appColors,
        );

        if (newColor != null) {
          selectedColor.value = newColor;
          onSelect?.call(newColor);
          hasSelectedColor.value = true;
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: selectedColor.value,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    hasSelectedColor.value ? '已選擇顏色' : '選擇顏色',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
