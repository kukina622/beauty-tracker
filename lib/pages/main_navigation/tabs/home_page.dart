import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/product/use_animated_product_list.dart';
import 'package:beauty_tracker/hooks/product/use_product_refresh_listener.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_easy_loading.dart';
import 'package:beauty_tracker/hooks/use_provider.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/providers/product_provider.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_status_request.dart';
import 'package:beauty_tracker/services/brand_service/brand_service.dart';
import 'package:beauty_tracker/services/category_service/category_service.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/sub_title_bar.dart';
import 'package:beauty_tracker/widgets/home/copy_product_button.dart';
import 'package:beauty_tracker/widgets/home/edit_mode_toggle_button.dart';
import 'package:beauty_tracker/widgets/home/expiring_soon_tile.dart';
import 'package:beauty_tracker/widgets/home/filter_bottom_sheet.dart';
import 'package:beauty_tracker/widgets/home/filter_button.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:beauty_tracker/widgets/product/animated_product_card_wrapper.dart';
import 'package:beauty_tracker/widgets/product/product_card.dart';
import 'package:beauty_tracker/widgets/product/product_status_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isInitialLoad = useState(true);
    final isEditStatusMode = useState(false);
    final pendingUpdates = useState<Map<String, ProductStatus>>({});
    final statusFilter = useState<ProductStatus>(ProductStatus.inUse);
    final brandFilter = useState<Brand?>(null);
    final categoryFilter = useState<Category?>(null);
    final easyLoading = useEasyLoading();

    final productService = useDi<ProductService>();
    final brandService = useDi<BrandService>();
    final categoryService = useDi<CategoryService>();
    final animatedListController = useAnimatedProductList();

    final productProvider = useProvider<ProductProvider>();

    final productsResult = useServiceData(
      () => productService.getProductsWithFilters(
        status: statusFilter.value,
        brandId: brandFilter.value?.id,
        categoryId: categoryFilter.value?.id,
      ),
    );

    final productsExpiringResult = useServiceData(
      () => productService.getExpiringSoonProducts(),
    );

    final brandsResult = useServiceData(
      () => brandService.getAllBrands(),
    );

    final categoriesResult = useServiceData(
      () => categoryService.getAllCategories(),
    );

    final products = useMemoized(() {
      if (productsResult.hasError || !productsResult.hasData) {
        return <Product>[];
      }

      final filteredProducts = productsResult.data!;
      return Product.sortByExpiryDate(filteredProducts, todayFirst: true);
    }, [productsResult.data]);

    useEffect(() {
      if (productsResult.loading && isInitialLoad.value) {
        easyLoading.show(status: '載入中...');
      } else {
        easyLoading.dismiss();
        isInitialLoad.value = false;
      }
      return null;
    }, [productsResult.loading]);

    useEffect(() {
      animatedListController.updateProducts(products);
      return null;
    }, [products]);

    // Listen for product provider changes to refresh data
    useProductRefreshListener(() {
      productsResult.refresh();
      productsExpiringResult.refresh();
    });

    final onConfirmUpdateProductStatus = useCallback(() async {
      if (pendingUpdates.value.isEmpty) {
        return;
      }

      final payloads = pendingUpdates.value.entries.map((entry) {
        return UpdateProductStatusRequest(
          productId: entry.key,
          status: entry.value,
        );
      }).toList();

      final result = await productService.bulkUpdateProductsStatus(payloads);

      switch (result) {
        case Ok():
          easyLoading.showSuccess('更新成功');
          pendingUpdates.value = {};
          productProvider.triggerRefresh();
          break;
        case Err():
          easyLoading.showError('更新失敗');
          break;
      }
    }, [productService, pendingUpdates]);

    final showFilterBottomSheet = useCallback(() {
      FilterBottomSheet.show(
        context,
        initialStatus: statusFilter.value,
        initialBrand: brandFilter.value,
        initialCategory: categoryFilter.value,
        brands: brandsResult.data ?? [],
        categories: categoriesResult.data ?? [],
        onApplyFilters: (status, brand, category) {
          statusFilter.value = status ?? ProductStatus.inUse;
          brandFilter.value = brand;
          categoryFilter.value = category;
          productsResult.refresh();
        },
      );
    }, [statusFilter, brandFilter, categoryFilter, brandsResult.data, categoriesResult.data]);

    return PageScrollView(
      enableRefresh: true,
      onRefresh: () => Future.wait([
        productsResult.refresh(),
        productsExpiringResult.refresh(),
      ]),
      header: [
        AppTitleBar(
          title: 'Beauty Tracker',
          actionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              EditModeToggleButton(
                onEditStateChanged: (mode) {
                  isEditStatusMode.value = mode == EditState.edit;
                },
                onConfirm: onConfirmUpdateProductStatus,
              ),
              SizedBox(width: 12),
              CopyProductButton(),
            ],
          ),
        ),
      ],
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              ExpiringSoonTile(
                expiringCount: productsExpiringResult.data?.length ?? 0,
                onTap: () {
                  // Navigate to Expiring Soon tab
                  AutoTabsRouter.of(context).setActiveIndex(1);
                },
              ),
              const SizedBox(height: 24),
              SubTitleBar(
                title: '狀態篩選',
                action: [
                  FilterButton(
                    onTap: showFilterBottomSheet,
                    isActive: brandFilter.value != null || categoryFilter.value != null,
                  ),
                ],
              ),
              SizedBox(height: 14),
              ProductStatusFilter(
                selectedStatus: statusFilter.value,
                onStatusChanged: (status) {
                  statusFilter.value = status;
                  productsResult.refresh();
                },
              ),
              const SizedBox(height: 18),
              SubTitleBar(title: '美妝品'),
            ],
          ),
        ),
        SliverAnimatedList(
          key: animatedListController.listKey,
          initialItemCount: animatedListController.products.length,
          itemBuilder: (context, index, animation) {
            if (index >= animatedListController.products.length) {
              return const SizedBox.shrink();
            }

            final product = animatedListController.products[index];

            return AnimatedProductCardWrapper(
              animation: animation,
              child: ProductCard(
                product: product,
                isEditStatusMode: isEditStatusMode.value,
                onStatusChanged: (status) {
                  pendingUpdates.value[product.id] = status;
                },
                onDelete: () {
                  productProvider.triggerRefresh();
                },
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 50),
        ),
      ],
    );
  }
}
