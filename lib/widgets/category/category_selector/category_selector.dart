import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/extensions/color.dart';
import 'package:beauty_tracker/widgets/category/category_selector/category_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategorySelector extends HookWidget {
  CategorySelector({super.key});

  final allCategories = [
    Category(
      id: '1',
      categoryName: 'Skincare',
      categoryIcon: Icons.face.codePoint,
      categoryColor: Colors.blue.toInt(),
    ),
    Category(
      id: '2',
      categoryName: 'Makeup',
      categoryIcon: Icons.brush.codePoint,
      categoryColor: Colors.pink.toInt(),
    ),
    Category(
      id: '3',
      categoryName: 'Haircare',
      categoryIcon: Icons.abc.codePoint,
      categoryColor: Colors.green.toInt(),
    ),
    Category(
      id: '4',
      categoryName: 'Nail Art',
      categoryIcon: Icons.access_alarm_rounded.codePoint,
      categoryColor: Colors.purple.toInt(),
    ),
    Category(
      id: '5',
      categoryName: 'Body Care',
      categoryIcon: Icons.hail.codePoint,
      categoryColor: Colors.orange.toInt(),
    ),
    Category(
      id: '6',
      categoryName: 'Fragrance',
      categoryIcon: Icons.cabin.codePoint,
      categoryColor: Colors.yellow.toInt(),
    ),
    Category(
      id: '7',
      categoryName: 'Tools',
      categoryIcon: Icons.build.codePoint,
      categoryColor: Colors.grey.toInt(),
    ),
  ];

  void _showCategorySelectionSheet(
    BuildContext context,
    ValueNotifier<List<String>> seletedCategoryIds,
  ) {
    CategorySelectionSheet.show(
      context,
      allCategories: allCategories,
      initialSelectedIds: seletedCategoryIds.value,
      onConfirmed: (selectedIds) {
        seletedCategoryIds.value = selectedIds;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final seletedCategoryIds = useState<List<String>>([]);

    return GestureDetector(
      onTap: () {
        _showCategorySelectionSheet(context, seletedCategoryIds);
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
              '選擇類別',
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
