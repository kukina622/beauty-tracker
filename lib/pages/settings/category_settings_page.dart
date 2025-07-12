import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_provider.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/providers/product_provider.dart';
import 'package:beauty_tracker/services/category_service/category_service.dart';
import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/category_form_dialog.dart';
import 'package:beauty_tracker/widgets/common/app_search_bar.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/icon_button/app_filled_icon_button.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:beauty_tracker/widgets/profile/settings/category_management_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class CategorySettingsPage extends HookWidget {
  const CategorySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = useProvider<ProductProvider>();

    final categoryService = useDi<CategoryService>();

    final categoryResult = useServiceData(
      () => categoryService.getAllCategories(),
    );

    final categories = categoryResult.data ?? [];

    final searchQuery = useState<String>('');

    final filteredCategories = useMemoized(() {
      if (searchQuery.value.isEmpty) {
        return categories;
      }
      return categories.where((category) {
        return category.categoryName.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }, [categories, searchQuery.value]);

    return PageScrollView(
      header: [
        AppTitleBar(
          title: '類別設定',
          actionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppFilledIconButton(
                icon: Icons.add,
                iconColor: const Color(0xFF2D3142),
                backgroundColor: Colors.white,
                size: 44.0,
                borderRadius: BorderRadius.circular(12),
                onPressed: () {
                  CategoryFormDialog.showCreate(
                    context,
                    onCategoryCreated: (newCategory) {
                      categoryResult.refresh();
                      productProvider.triggerRefresh();
                    },
                  );
                },
              ),
            ],
          ),
          backButtonEnabled: true,
        )
      ],
      slivers: [
        SliverToBoxAdapter(
          child: AppSearchBar(
            hintText: '搜尋類別',
            onChanged: (p0) => searchQuery.value = p0,
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          delegate: SliverChildBuilderDelegate(
            childCount: filteredCategories.length,
            (context, index) {
              return CategoryManagementCard(
                category: filteredCategories[index],
                onEdit: () {
                  CategoryFormDialog.showEdit(
                    context,
                    category: filteredCategories[index],
                    onCategoryUpdated: (updatedCategory) {
                      categoryResult.refresh();
                      productProvider.triggerRefresh();
                    },
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
