import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/product/use_animated_product_list.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_status_requests.dart';
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
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class HomePage extends StatefulHookWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isInitialLoad = useState(true);
    final isEditStatusMode = useState(false);
    final productStatus = useState<ProductStatus>(ProductStatus.inUse);
    final pendingUpdates = useState<Map<String, ProductStatus>>({});

    final productService = useDi<ProductService>();
    final animatedListController = useAnimatedProductList();

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

      final DateTime now = DateTime.now();

      return productsResult.data!.sorted(
        (a, b) {
          final aExpiry = a.expiryDate.difference(now).inDays;
          final bExpiry = b.expiryDate.difference(now).inDays;
          return aExpiry.compareTo(bExpiry);
        },
      );
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

    final onConfirmUpdateProductStatus = useCallback(() async {
      if (pendingUpdates.value.isEmpty) {
        return;
      }

      final payloads = pendingUpdates.value.entries.map((entry) {
        return UpdateProductStatusRequests(
          productId: entry.key,
          status: entry.value,
        );
      }).toList();

      final result = await productService.bulkUpdateProductsStatus(payloads);

      switch (result) {
        case Ok():
          EasyLoading.showSuccess('更新成功', maskType: EasyLoadingMaskType.black);
          pendingUpdates.value = {};
          await productsResult.refresh();
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
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ExpiringSoonTile(
                expiringCount: productsExpiringResult.data?.length ?? 0,
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

            return AnimatedProductCardWrapper(
              animation: animation,
              child: ProductCard(
                product: animatedListController.products[index],
                isEditStatusMode: isEditStatusMode.value,
                onStatusChanged: (status) {
                  pendingUpdates.value[animatedListController.products[index].id] = status;
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
