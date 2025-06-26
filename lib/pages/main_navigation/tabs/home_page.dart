import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
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
import 'package:beauty_tracker/widgets/product/product_card.dart';
import 'package:beauty_tracker/widgets/product/product_status_filter.dart';
import 'package:collection/collection.dart';
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

    final productsResult = useServiceData(
      () => productService.getProductByStatus(productStatus.value),
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
              ExpiringSoonTile(),
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: products.length,
            (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ProductCard(
                  product: products[index],
                  isEditStatusMode: isEditStatusMode.value,
                  onStatusChanged: (status) {
                    pendingUpdates.value[products[index].id] = status;
                  },
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 50),
        ),
      ],
    );
  }
}
