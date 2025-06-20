import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/widgets/category/category_selector/category_selection_sheet.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    this.allCategories = const [],
    this.selectedCategoryIds = const [],
    this.onCategorySelected,
  });

  final List<Category> allCategories;
  final List<String> selectedCategoryIds;
  final void Function(List<String>)? onCategorySelected;

  void _showCategorySelectionSheet(
    BuildContext context,
    List<String> currentSelectedIds,
  ) {
    CategorySelectionSheet.show(
      context,
      allCategories: allCategories,
      initialSelectedIds: currentSelectedIds,
      onConfirmed: (selectedIds) {
        onCategorySelected?.call(selectedIds);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCategorySelectionSheet(context, selectedCategoryIds);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedCategoryIds.isEmpty
                  ? '選擇類別'
                  : '已選擇 ${selectedCategoryIds.length} 個類別', // 顯示選中狀態
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF2D3142),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF2D3142),
            ),
          ],
        ),
      ),
    );
  }
}
