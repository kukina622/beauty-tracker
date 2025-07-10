import 'package:flutter/material.dart';

class SelectorItem<T> extends StatelessWidget {
  const SelectorItem({
    super.key,
    required this.item,
    required this.title,
    this.icon,
    this.color,
    this.isSelected = false,
    this.onSelected,
  });

  final T item;
  final String title;
  final IconData? icon;
  final Color? color;
  final bool isSelected;
  final void Function(T)? onSelected;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).primaryColor;

    return InkWell(
      onTap: () => onSelected?.call(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: .1) : Colors.white,
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade200,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: const Color(0xFF2D3142),
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
