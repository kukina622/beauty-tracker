import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChipData {
  ChipData({required this.label, required this.value, this.icon, required this.color});
  final String label;
  final String value;
  final IconData? icon;
  final Color color;
}

class ChipGroup extends HookWidget {
  const ChipGroup({super.key, this.chips = const [], this.onSelected, this.defaultValue});
  final List<ChipData> chips;
  final void Function(String)? onSelected;
  final String? defaultValue;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String?> selected = useState(defaultValue);

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: chips.map((chip) {
            final isSelected = selected.value == chip.value;
            final Color mainColor = chip.color;

            return GestureDetector(
              onTap: () {
                selected.value = chip.value;
                if (onSelected != null) {
                  onSelected!(chip.value);
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [mainColor, mainColor.withValues(alpha: 0.8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    if (chip.icon != null)
                      Icon(
                        chip.icon,
                        color: isSelected ? Colors.white : mainColor,
                        size: 16,
                      ),
                    if (chip.icon != null) const SizedBox(width: 6),
                    Text(
                      chip.label,
                      style: TextStyle(
                        color: isSelected ? Colors.white : mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
