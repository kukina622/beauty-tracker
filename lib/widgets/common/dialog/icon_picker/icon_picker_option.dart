import 'package:flutter/material.dart';

class IconPickerOption extends StatelessWidget {
  const IconPickerOption({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onSelect,
  });
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF9A9E).withValues(alpha: .2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: const Color(0xFFFF9A9E)) : null,
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFFFF9A9E) : Colors.grey.shade700,
          size: 24,
        ),
      ),
    );
  }
}
