import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChipData<T> {
  ChipData({
    required this.label,
    required this.value,
    this.icon,
    required this.color,
    this.border,
  });
  final String label;
  final T value;
  final IconData? icon;
  final Color color;
  final BoxBorder? border;
}

class ChipGroup<T> extends HookWidget {
  const ChipGroup({
    super.key,
    this.chips = const [],
    this.onSelected,
    this.selectedValue,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.margin = const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    this.iconSize = 16,
    this.fontSize = 14,
  });
  final List<ChipData<T>> chips;
  final void Function(T)? onSelected;
  final T? selectedValue;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double iconSize;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<T?> selected = useState(selectedValue);
    
    useEffect(() {
      selected.value = selectedValue;
      return null;
    }, [selectedValue]);

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
                margin: margin,
                padding: padding,
                decoration: BoxDecoration(
                  border: chip.border,
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
                        size: iconSize,
                      ),
                    if (chip.icon != null) const SizedBox(width: 6),
                    Text(
                      chip.label,
                      style: TextStyle(
                        color: isSelected ? Colors.white : mainColor,
                        fontSize: fontSize,
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
