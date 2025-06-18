import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/extensions/color.dart';
import 'package:beauty_tracker/widgets/category/category_selector/category_selector_item.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
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
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('選擇類別', style: Theme.of(context).textTheme.titleLarge),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              seletedCategoryIds.value.clear();
                            });
                          },
                          child: const Text('清除全部'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 32, color: const Color.fromARGB(255, 255, 255, 255)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    ...allCategories.map(
                      (category) => CategorySelectorItem(
                        category: category,
                        isSelected: seletedCategoryIds.value.contains(category.id),
                        onSelected: () {
                          setModalState(() {
                            if (seletedCategoryIds.value.contains(category.id)) {
                              seletedCategoryIds.value.remove(category.id);
                            } else {
                              seletedCategoryIds.value.add(category.id);
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: AppElevatedButton(
                  height: 56,
                  text: '確定',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isFilled: true,
                ),
              )
            ],
          ),
        ),
      ),
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
