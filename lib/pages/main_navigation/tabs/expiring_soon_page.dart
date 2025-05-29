import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/util/extensions/color.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/product/product_card.dart';
import 'package:beauty_tracker/widgets/tabs/tab_page_scroll_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ExpiringSoonPage extends StatelessWidget {
  const ExpiringSoonPage({super.key});
  List<Product> get products => [
        Product(
          id: '2',
          name: 'Sunscreen',
          brand: 'Brand B',
          price: 19.99,
          purchaseDate: DateTime(2023, 2, 20),
          expiryDate: DateTime(2025, 6, 20),
          categories: [
            Category(
              id: '789',
              categoryName: 'Sunscreen',
              categoryIcon: Icons.sunny.codePoint,
              categoryColor: Colors.yellow.shade700.toInt(),
            ),
          ],
        ),
        Product(
          id: '3',
          name: 'Serum',
          brand: 'Brand C',
          price: 49.99,
          purchaseDate: DateTime(2023, 3, 10),
          expiryDate: DateTime(2025, 6, 10),
          categories: [
            Category(
              id: '101',
              categoryName: 'Serum',
              categoryIcon: Icons.healing.codePoint,
              categoryColor: Colors.green.shade200.toInt(),
            ),
            Category(
              id: '102',
              categoryName: 'Anti-aging',
              categoryIcon: Icons.timer.codePoint,
              categoryColor: Colors.orange.shade300.toInt(),
            ),
            Category(
              id: '103',
              categoryName: 'Brightening',
              categoryIcon: Icons.light_mode.codePoint,
              categoryColor: Colors.pink.shade200.toInt(),
            ),
            Category(
              id: '104',
              categoryName: 'Hydrating',
              categoryIcon: Icons.water_drop.codePoint,
              categoryColor: Colors.blue.shade200.toInt(),
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return TabPageScrollView(
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
          child: SizedBox(height: 10),
        ),
      ],
    );
  }
}
