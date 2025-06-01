import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/category/category_chip.dart';
import 'package:beauty_tracker/widgets/common/app_card.dart';
import 'package:beauty_tracker/widgets/common/chip/icon_chip.dart';
import 'package:beauty_tracker/widgets/common/icon_button/app_standard_icon_button.dart';
import 'package:beauty_tracker/widgets/product/expiring_chip.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  Widget _buildProductImage({Category? category}) {
    final color = Color(category?.categoryColor ?? 0xFFB5EAEA);
    final icon = getIcon(category?.categoryIcon);
    return IconChip(
      icon: icon,
      backgroundColor: color.withValues(alpha: .2),
      iconColor: color,
    );
  }

  Widget _buildProductInfo({
    required String name,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 8),
          // Expiry status
          ExpiringChip(expiryDate: product.expiryDate),
        ],
      ),
    );
  }

  Widget _buildProductActions({
    required double price,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppStandardIconButton(
              icon: Icons.edit,
              onPressed: onEdit,
              iconColor: const Color(0xFF5ECCC4),
              size: 20,
            ),
            const SizedBox(width: 8),
            AppStandardIconButton(
              icon: Icons.delete_outline,
              onPressed: onDelete,
              iconColor: const Color(0xFFFF6B6B),
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildProductCategory({List<Category>? categories = const []}) {
    if (categories?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        height: 28,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: categories!.map((category) {
            return Container(
              margin: const EdgeInsets.only(right: 8),
              child: CategoryChip(category: category),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(
                  category: product.categories?.firstOrNull,
                ),
                const SizedBox(width: 16),
                _buildProductInfo(
                  name: product.name,
                ),
                _buildProductActions(
                  price: product.price,
                  onEdit: () {},
                  onDelete: () {},
                ),
              ],
            ),
          ),
          _buildProductCategory(
            categories: product.categories,
          ),
        ],
      ),
    );
  }
}
