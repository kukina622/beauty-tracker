import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/category/category_chip.dart';
import 'package:beauty_tracker/widgets/common/chip/text_icon_chip.dart';
import 'package:flutter/material.dart';

class DismissibleCategoryChip extends CategoryChip {
  const DismissibleCategoryChip({super.key, required super.category, required this.onDismissed});
  final void Function() onDismissed;

  @override
  Widget build(BuildContext context) {
    return TextIconChip(
      text: category.categoryName,
      icon: getAppIcon(category.categoryIcon),
      iconColor: categoryColor,
      textColor: categoryColor,
      backgroundColor: categoryColor.withValues(alpha: .2),
      borderColor: categoryColor.withValues(alpha: 0.3),
      iconSize: 14,
      fontSize: 12,
      borderWidth: 1,
      suffixIcon: Icons.close,
      onSuffixIconPressed: onDismissed,
    );
  }
}
