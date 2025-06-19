import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/common/dialog/color_picker/color_picker_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ColorPicker extends HookWidget {
  const ColorPicker({super.key, this.allColors = const [], this.initialColor});
  final List<Color> allColors;
  final Color? initialColor;

  static Future<Color?> show(
    BuildContext context, {
    Color? initialColor,
    List<Color> allColors = const [],
  }) {
    return showDialog<Color>(
      context: context,
      builder: (_) => ColorPicker(
        allColors: allColors,
        initialColor: initialColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = useState(initialColor);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '選擇顏色',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              width: double.maxFinite,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: allColors.length,
                itemBuilder: (context, index) {
                  final color = allColors[index];
                  final isSelected = color == currentColor.value;
                  return ColorPickerOption(
                    color: color,
                    isSelected: isSelected,
                    onSelect: () {
                      currentColor.value = color;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            AppElevatedButton(
              isFilled: true,
              onPressed: () {
                Navigator.of(context).pop(currentColor.value);
              },
              text: '確認',
            ),
          ],
        ),
      ),
    );
  }
}
