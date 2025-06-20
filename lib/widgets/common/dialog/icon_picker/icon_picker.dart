import 'package:beauty_tracker/widgets/common/dialog/app_dialog.dart';
import 'package:beauty_tracker/widgets/common/dialog/icon_picker/icon_picker_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IconPicker extends HookWidget {
  const IconPicker({super.key, this.allIcons = const [], this.initialIcon});
  final List<IconData> allIcons;
  final IconData? initialIcon;

  static Future<IconData?> show(
    BuildContext context, {
    IconData? initialIcon,
    List<IconData> allIcons = const [],
  }) {
    return showDialog<IconData>(
      context: context,
      builder: (_) => IconPicker(
        allIcons: allIcons,
        initialIcon: initialIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIcon = useState<IconData?>(initialIcon);

    return AppDialog(
      title: '選擇圖示',
      showCancel: false,
      onConfirm: () {
        Navigator.of(context).pop(currentIcon.value);
      },
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 300,
            width: double.maxFinite,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: allIcons.length,
              itemBuilder: (context, index) {
                final icon = allIcons[index];
                final isSelected = icon == currentIcon.value;
                return IconPickerOption(
                  icon: icon,
                  isSelected: isSelected,
                  onSelect: () {
                    currentIcon.value = icon;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
