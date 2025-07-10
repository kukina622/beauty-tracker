import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_provider.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/providers/product_provider.dart';
import 'package:beauty_tracker/requests/product_requests/create_product_request.dart';
import 'package:beauty_tracker/services/brand_service/brand_service.dart';
import 'package:beauty_tracker/services/category_service/category_service.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:beauty_tracker/widgets/brand/brand_selector/brand_selector.dart';
import 'package:beauty_tracker/widgets/category/category_selector/category_selector.dart';
import 'package:beauty_tracker/widgets/category/dismissible_category_chip.dart';
import 'package:beauty_tracker/widgets/common/app_card.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:beauty_tracker/widgets/form/date_picker_field.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    final productService = useDi<ProductService>();
    final brandService = useDi<BrandService>();

    final productNameController = useTextEditingController();
    final priceController = useTextEditingController();
    final selectedBrandIds = useState<String?>(null);
    final selectedCategoryIds = useState<List<String>>([]);
    final purchaseDate = useState<DateTime?>(null);
    final expirationDate = useState<DateTime?>(null);
    final productProvider = useProvider<ProductProvider>();

    final categoryResult = useServiceData(
      () => categoryService.getAllCategories(),
    );

    final allCategories = categoryResult.data ?? [];

    final brandResult = useServiceData(
      () => brandService.getAllBrands(),
    );

    final allBrands = brandResult.data ?? [];

    final onCreateNewProduct = useCallback(() async {
      final bool isFormValid = _formKey.currentState?.validate() ?? false;
      if (isFormValid) {
        final productName = productNameController.text.trim();
        final brand = selectedBrandIds.value;
        final price = double.tryParse(priceController.text.trim());
        final purchaseDateValue = purchaseDate.value;
        final expirationDateValue = expirationDate.value;
        final categories = selectedCategoryIds.value;

        final product = CreateProductRequest(
          name: productName,
          brand: brand,
          price: price,
          purchaseDate: purchaseDateValue,
          expiryDate: expirationDateValue,
          categories: categories,
        );

        final result = await productService.createNewProduct(product);

        switch (result) {
          case Ok():
            EasyLoading.showSuccess('新增成功', maskType: EasyLoadingMaskType.black);
            productProvider.triggerRefresh();
            if (context.mounted) {
              AutoRouter.of(context).pop();
            }
            break;
          case Err():
            EasyLoading.showError('新增失敗', maskType: EasyLoadingMaskType.black);
            break;
        }
      }
    }, [
      _formKey,
      productNameController,
      priceController,
      purchaseDate,
      expirationDate,
      selectedCategoryIds,
      selectedBrandIds,
      productService
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('新增美妝品'),
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
                          '美妝品細項',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 24),
                        BaseFormField(
                          labelText: '產品名稱',
                          hintText: '輸入產品名稱',
                          controller: productNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '請輸入產品名稱';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        BaseFormField(
                          labelText: '價格(可選)',
                          hintText: '輸入價格',
                          prefixText: '\$ ',
                          controller: priceController,
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              final price = double.tryParse(value);
                              if (price == null) {
                                return '請輸入有效的價格';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '品牌',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        BrandSelector(
                          allBrands: allBrands,
                          selectedBrandId: selectedBrandIds.value,
                          onBrandSelected: (brand) => selectedBrandIds.value = brand,
                          onBrandCreated: (brand) {
                            final currentBrands = brandResult.data ?? [];
                            brandResult.mutate([...currentBrands, brand]);
                          },
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
                        DatePickerField(
                          onDateChanged: (p0) => purchaseDate.value = p0,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '過期日',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        DatePickerField(
                          onDateChanged: (p0) => expirationDate.value = p0,
                          validator: (p0) {
                            if (p0 == null) {
                              return '請選擇過期日';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  AppElevatedButton(
                    text: '新增美妝品',
                    onPressed: onCreateNewProduct,
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
