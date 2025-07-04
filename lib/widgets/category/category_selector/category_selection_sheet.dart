import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/widgets/category/category_selector/category_selector_item.dart';
import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/category_form_dialog.dart';
import 'package:beauty_tracker/widgets/common/button/app_outlined_button.dart';
import 'package:beauty_tracker/widgets/common/sheet/selection_sheet/selection_sheet.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class CategorySelectionSheet {
  static Future<void> show(
    BuildContext context, {
    required List<Category> allCategories,
    required List<String> initialSelectedIds,
    required void Function(List<String>) onConfirmed,
    void Function(Category)? onCategoryCreated,
  }) {
    final initialSelectedCategories =
        allCategories.where((category) => initialSelectedIds.contains(category.id)).toList();

    return SelectionSheet.show<Category>(
      context,
      title: '選擇類別',
      allItems: allCategories,
      initialSelectedItems: initialSelectedCategories,
      onConfirmed: (selectedCategories) {
        final selectedIds = selectedCategories.map((c) => c.id).toList();
        onConfirmed(selectedIds);
      },
      itemBuilder: (category, isSelected, onSelected) => CategorySelectorItem(
        category: category,
        isSelected: isSelected,
        onSelected: onSelected,
      ),
      bottomActionWidget: AppOutlinedButton(
        isFilled: true,
        text: '加入新類別',
        icon: Icons.add_circle_outline,
        onPressed: () {
          CategoryFormDialog.show(
            context,
            onCategoryCreated: (category) {
              onCategoryCreated?.call(category);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
