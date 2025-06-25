import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/sub_title_bar.dart';
import 'package:beauty_tracker/widgets/home/edit_mode_toggle_button.dart';
import 'package:beauty_tracker/widgets/home/expiring_soon_tile.dart';
import 'package:beauty_tracker/widgets/home/notification_button.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
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
    final isEditStatusMode = useState(false);
    final productStatus = useState<ProductStatus>(ProductStatus.inUse);
    final productService = useDi<ProductService>();

    final allProductsFuture = useMemoized(
      () => productService.getProductByStatus(productStatus.value),
      [productStatus.value],
    );

    final snapshot = useFuture(allProductsFuture);

    final List<Product> products = useMemoized(() {
      if (snapshot.connectionState != ConnectionState.done || snapshot.data == null) {
        return [];
      }
      switch (snapshot.data!) {
        case Ok(value: final List<Product> productList):
          return productList;
        case Err():
          EasyLoading.showError('載入資料失敗', maskType: EasyLoadingMaskType.black);
          return [];
      }
    }, [snapshot.connectionState, snapshot.data]);

    useEffect(() {
      if (snapshot.connectionState == ConnectionState.waiting) {
        EasyLoading.show(
          status: '載入中...',
          maskType: EasyLoadingMaskType.black,
        );
      } else {
        EasyLoading.dismiss();
      }
      return null;
    }, [snapshot.connectionState]);

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
                onStatusChanged: (status) => productStatus.value = status,
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
