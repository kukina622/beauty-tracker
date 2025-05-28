import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/widgets/category/category_filter.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/home/expiring_soon_tile.dart';
import 'package:beauty_tracker/widgets/home/notification_button.dart';
import 'package:beauty_tracker/widgets/home/sub_title_bar.dart';
import 'package:beauty_tracker/widgets/product/product_card.dart';
import 'package:beauty_tracker/widgets/tabs/tab_page_scroll_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Product> get products => [
        Product(
            id: '1',
            name: 'Moisturizer',
            brand: 'Brand A',
            price: 29.99,
            purchaseDate: DateTime(2023, 1, 15),
            expiryDate: DateTime(2024, 1, 15),
            categories: [
              Category(
                id: '123',
                categoryName: 'Moisturizer',
                categoryIcon: Icons.spa.codePoint,
                categoryColor: Colors.red.shade200.value,
              ),
              Category(
                id: '456',
                categoryName: 'Hydration',
                categoryIcon: Icons.water.codePoint,
                categoryColor: Colors.blue.shade300.value,
              ),
            ]),
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
              categoryColor: Colors.yellow.shade700.value,
            ),
          ],
        ),
        Product(
          id: '3',
          name: 'Serum',
          brand: 'Brand C',
          price: 49.99,
          purchaseDate: DateTime(2023, 3, 10),
          expiryDate: DateTime(2024, 3, 10),
          categories: [
            Category(
              id: '101',
              categoryName: 'Serum',
              categoryIcon: Icons.healing.codePoint,
              categoryColor: Colors.green.shade200.value,
            ),
            Category(
              id: '102',
              categoryName: 'Anti-aging',
              categoryIcon: Icons.timer.codePoint,
              categoryColor: Colors.orange.shade300.value,
            ),
            Category(
              id: '103',
              categoryName: 'Brightening',
              categoryIcon: Icons.light_mode.codePoint,
              categoryColor: Colors.pink.shade200.value,
            ),
            Category(
              id: '104',
              categoryName: 'Hydrating',
              categoryIcon: Icons.water_drop.codePoint,
              categoryColor: Colors.blue.shade200.value,
            ),
          ],
        ),
        Product(
          id: '4',
          name: 'Face Mask',
          brand: 'Brand D',
          price: 15.99,
          purchaseDate: DateTime(2023, 4, 5),
          expiryDate: DateTime(2024, 4, 5),
          categories: [
            Category(
              id: '102',
              categoryName: 'Face Mask',
              categoryIcon: Icons.masks.codePoint,
              categoryColor: Colors.purple.shade200.value,
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return TabPageScrollView(
      header: [
        AppTitleBar(
          title: 'Beauty Tracker',
          subtitle: 'Track your beauty products',
          actionButton: NotificationButton(),
        ),
      ],
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ExpiringSoonTile(),
              const SizedBox(height: 24),
              SubTitleBar(title: '所有分類'),
              SizedBox(height: 14),
              CategoryFilter(),
              const SizedBox(height: 18),
              SubTitleBar(title: '保養品', enableAddOption: false),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: products.length,
            (context, index) => ProductCard(product: products[index]),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),
      ],
    );
  }
}
