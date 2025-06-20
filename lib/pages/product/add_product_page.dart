import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/extensions/color.dart';
import 'package:beauty_tracker/widgets/category/category_selector/category_selector.dart';
import 'package:beauty_tracker/widgets/category/dismissible_category_chip.dart';
import 'package:beauty_tracker/widgets/common/app_card.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:beauty_tracker/widgets/form/date_picker_field.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class AddProductPage extends HookWidget {
  AddProductPage({super.key});

  final _formKey = GlobalKey<FormState>();
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

  Widget _buildSelectCategoryItems(
    BuildContext context,
    List<Category> categories,
    ValueNotifier<List<String>> selectedIds,
  ) {
    final selectedCategories =
        categories.where((category) => selectedIds.value.contains(category.id)).toList();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: selectedCategories.map((category) {
        return DismissibleCategoryChip(
          category: category,
          onDismissed: () {
            selectedIds.value = selectedIds.value.where((id) => id != category.id).toList();
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategoryIds = useState<List<String>>([]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('新增保養品'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => AutoRouter.of(context).pop(),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: PageScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppCard(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '保養品細項',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 24),
                        BaseFormField(
                          labelText: '產品名稱',
                          hintText: '輸入產品名稱',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '請輸入產品名稱';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        BaseFormField(
                          labelText: '品牌(可選)',
                          hintText: '輸入品牌名稱',
                        ),
                        const SizedBox(height: 16),
                        BaseFormField(
                          labelText: '價格(可選)',
                          hintText: '輸入價格',
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '類別',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        CategorySelector(
                          allCategories: allCategories,
                          selectedCategoryIds: selectedCategoryIds.value,
                          onCategorySelected: (categoryIds) {
                            selectedCategoryIds.value = categoryIds;
                          },
                        ),
                        const SizedBox(height: 6),
                        _buildSelectCategoryItems(
                          context,
                          allCategories,
                          selectedCategoryIds,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '購買日期',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        DatePickerField(),
                        const SizedBox(height: 16),
                        Text(
                          '過期日',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        DatePickerField()
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  AppElevatedButton(
                    text: '新增保養品',
                    onPressed: () {
                      final bool isFormValid = _formKey.currentState?.validate() ?? false;
                      if (isFormValid) {}
                    },
                    isFilled: true,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
