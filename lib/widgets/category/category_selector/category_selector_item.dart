import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:flutter/material.dart';

class CategorySelectorItem extends StatelessWidget {
  const CategorySelectorItem({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onSelected,
  });

  final Category category;
  final bool isSelected;
  final VoidCallback? onSelected;

  Color get categoryColor => Color(category.categoryColor);
  IconData get categoryIcon => getAppIcon(category.categoryIcon);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? categoryColor.withValues(alpha: .1) : Colors.white,
          border: Border.all(
            color: isSelected ? categoryColor : Colors.grey.shade200,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: categoryColor.withValues(alpha: .2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                categoryIcon,
                color: categoryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                category.categoryName,
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
                color: categoryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
