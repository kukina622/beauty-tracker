import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key, required this.category});

  final Category category;

  Color get categoryColor => Color(category.categoryColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: categoryColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            getIcon(category.categoryIcon),
            color: categoryColor,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            category.categoryName,
            style: TextStyle(
              fontSize: 12,
              color: categoryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
