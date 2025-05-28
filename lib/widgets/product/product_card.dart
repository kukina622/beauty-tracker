import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/product/expiring_chip.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  Widget _buildProductImage({Category? category}) {
    final color = Color(category?.categoryColor ?? 0xFFB5EAEA);
    final icon = getIcon(category?.categoryIcon);

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
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
            GestureDetector(
              onTap: onEdit,
              child: Icon(
                Icons.edit,
                color: const Color(0xFF5ECCC4),
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.delete_outline,
                color: const Color(0xFFFF6B6B),
                size: 20,
              ),
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
            final categoryColor = Color(category.categoryColor);
            return Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: categoryColor.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: categoryColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    getIcon(category.categoryIcon),
                    color: categoryColor,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    category.categoryName,
                    style: TextStyle(
                      fontSize: 12,
                      color: categoryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
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
