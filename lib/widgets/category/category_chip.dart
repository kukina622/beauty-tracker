import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/common/chip/text_icon_chip.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key, required this.category});

  final Category category;

  Color get categoryColor => Color(category.categoryColor);

  @override
  Widget build(BuildContext context) {
    return TextIconChip(
      text: category.categoryName,
      icon: getIcon(category.categoryIcon),
      iconColor: categoryColor,
      textColor: categoryColor,
      backgroundColor: categoryColor.withValues(alpha: .2),
      borderColor: categoryColor.withValues(alpha: 0.3),
      iconSize: 14,
      fontSize: 12,
      borderWidth: 1,
    );
  }
}
