import 'package:flutter/material.dart';

class ColorPickerOption extends StatelessWidget {
  const ColorPickerOption({
    super.key,
    required this.color,
    this.isSelected = false,
    this.onSelect,
  });

  final Color color;
  final bool isSelected;
  final void Function()? onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: .5),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
