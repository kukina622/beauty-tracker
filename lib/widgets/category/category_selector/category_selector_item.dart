import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/common/sheet/selection_sheet/selector_item.dart';
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
    return SelectorItem<Category>(
      item: category,
      title: category.categoryName,
      icon: categoryIcon,
      color: categoryColor,
      isSelected: isSelected,
      onSelected: (_) => onSelected?.call(),
    );
  }
}
