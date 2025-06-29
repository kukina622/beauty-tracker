import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/services/category_service/category_service.dart';
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
    final categoryService = useDi<CategoryService>();

    final selectedCategoryIds = useState<List<String>>([]);

    final categoryResult = useServiceData(
      () => categoryService.getAllCategories(),
    );

    final allCategories = categoryResult.data ?? [];

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
                          prefixText: '\$ ',
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
                          onCategoryCreated: (category) {
                            final currentCategories = categoryResult.data ?? [];
                            categoryResult.mutate([...currentCategories, category]);
                          },
                        ),
                        const SizedBox(height: 8),
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
