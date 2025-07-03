import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/hooks/product/use_product_refresh_listener.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:beauty_tracker/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class ExpiringSoonPage extends HookWidget {
  const ExpiringSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = useDi<ProductService>();

    final productsResult = useServiceData(
      () => productService.getExpiringSoonProducts(),
    );

    final products = useMemoized(() {
      if (productsResult.hasError || !productsResult.hasData) {
        return <Product>[];
      }

      return Product.sortByExpiryDate(productsResult.data!);
    }, [productsResult.data]);

    useProductRefreshListener(() {
      productsResult.refresh();
      productsResult.refresh();
    });

    return PageScrollView(
      header: [
        AppTitleBar(
          title: 'Expiring Soon',
          subtitle: 'Products that need your attention',
        ),
      ],
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: products.length,
            (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ProductCard(
                  product: products[index],
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
