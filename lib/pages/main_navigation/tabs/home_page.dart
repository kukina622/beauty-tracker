import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/product/use_animated_product_list.dart';
import 'package:beauty_tracker/hooks/product/use_product_refresh_listener.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_provider.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/providers/product_provider.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_status_request.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/sub_title_bar.dart';
import 'package:beauty_tracker/widgets/home/edit_mode_toggle_button.dart';
import 'package:beauty_tracker/widgets/home/expiring_soon_tile.dart';
import 'package:beauty_tracker/widgets/home/notification_button.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:beauty_tracker/widgets/product/animated_product_card_wrapper.dart';
import 'package:beauty_tracker/widgets/product/product_card.dart';
import 'package:beauty_tracker/widgets/product/product_status_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isInitialLoad = useState(true);
    final isEditStatusMode = useState(false);
    final productStatus = useState<ProductStatus>(ProductStatus.inUse);
    final pendingUpdates = useState<Map<String, ProductStatus>>({});

    final productService = useDi<ProductService>();
    final animatedListController = useAnimatedProductList();

    final productProvider = useProvider<ProductProvider>();

    final productsResult = useServiceData(
      () => productService.getProductByStatus(productStatus.value),
    );

    final productsExpiringResult = useServiceData(
      () => productService.getExpiringSoonProducts(),
    );

    final products = useMemoized(() {
      if (productsResult.hasError || !productsResult.hasData) {
        return <Product>[];
      }

      return Product.sortByExpiryDate(productsResult.data!);
    }, [productsResult.data]);

    useEffect(() {
      if (productsResult.loading && isInitialLoad.value) {
        EasyLoading.show(
          status: '載入中...',
          maskType: EasyLoadingMaskType.black,
        );
      } else {
        EasyLoading.dismiss();
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
          EasyLoading.showSuccess('更新成功', maskType: EasyLoadingMaskType.black);
          pendingUpdates.value = {};
          productProvider.triggerRefresh();
          break;
        case Err():
          EasyLoading.showError('更新失敗', maskType: EasyLoadingMaskType.black);
          break;
      }
    }, [productService, pendingUpdates]);

    return PageScrollView(
      header: [
        AppTitleBar(
          title: 'Beauty Tracker',
          subtitle: 'Track your beauty products',
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
              NotificationButton(),
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
              SubTitleBar(title: '狀態篩選'),
              SizedBox(height: 14),
              ProductStatusFilter(
                initialStatus: ProductStatus.inUse,
                onStatusChanged: (status) {
                  productStatus.value = status;
                  productsResult.refresh();
                },
              ),
              const SizedBox(height: 18),
              SubTitleBar(title: '保養品'),
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
