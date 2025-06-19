import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/common/dialog/icon_picker/icon_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IconSelectorField extends HookWidget {
  const IconSelectorField({
    super.key,
    this.initialIcon = Icons.face,
    this.onSelect,
  });

  final IconData initialIcon;
  final void Function(IconData?)? onSelect;

  @override
  Widget build(BuildContext context) {
    final selectedIcon = useState<IconData>(initialIcon);

    return GestureDetector(
      onTap: () async {
        final newIcon = await IconPicker.show(
          context,
          allIcons: appIcons,
          initialIcon: selectedIcon.value,
        );

        if (newIcon != null) {
          selectedIcon.value = newIcon;
          onSelect?.call(newIcon);
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
                      color: const Color(0xFFFF9A9E).withValues(alpha: .2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      selectedIcon.value,
                      color: const Color(0xFFFF9A9E),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '選擇圖示',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
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
