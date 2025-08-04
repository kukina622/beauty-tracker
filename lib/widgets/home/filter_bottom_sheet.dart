import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FilterBottomSheet extends HookWidget {
  const FilterBottomSheet({
    super.key,
    required this.initialStatus,
    required this.initialBrand,
    required this.initialCategory,
    required this.brands,
    required this.categories,
    required this.onApplyFilters,
  });

  static Future<bool?> show(
    BuildContext context, {
    required ProductStatus? initialStatus,
    required Brand? initialBrand,
    required Category? initialCategory,
    required List<Brand> brands,
    required List<Category> categories,
    required void Function(ProductStatus?, Brand?, Category?) onApplyFilters,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FilterBottomSheet(
          initialStatus: initialStatus,
          initialBrand: initialBrand,
          initialCategory: initialCategory,
          brands: brands,
          categories: categories,
          onApplyFilters: onApplyFilters,
        );
      },
    );
  }

  final ProductStatus? initialStatus;
  final Brand? initialBrand;
  final Category? initialCategory;
  final List<Brand> brands;
  final List<Category> categories;
  final void Function(ProductStatus?, Brand?, Category?) onApplyFilters;

  @override
  Widget build(BuildContext context) {
    // 內部管理暫時狀態
    final tempStatus = useState<ProductStatus?>(initialStatus);
    final tempBrand = useState<Brand?>(initialBrand);
    final tempCategory = useState<Category?>(initialCategory);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '篩選選項',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              TextButton(
                onPressed: () {
                  tempStatus.value = ProductStatus.inUse;
                  tempBrand.value = null;
                  tempCategory.value = null;
                },
                child: const Text(
                  '清除全部',
                  style: TextStyle(
                    color: Color(0xFFFF9A9E),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildFilterSection<ProductStatus>(
            title: '狀態',
            items: ProductStatus.values,
            chipBuilder: (status) {
              return ValueListenableBuilder<ProductStatus?>(
                valueListenable: tempStatus,
                builder: (context, currentStatus, _) {
                  final isSelected = currentStatus == status;
                  return _buildStatusFilterChip(
                    label: status.displayName,
                    status: status,
                    isSelected: isSelected,
                    onTap: () {
                      tempStatus.value = status;
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          _buildFilterSection<Brand>(
            title: '品牌',
            items: brands,
            emptyMessage: '無品牌資料',
            chipBuilder: (brand) {
              return ValueListenableBuilder<Brand?>(
                valueListenable: tempBrand,
                builder: (context, currentBrand, _) {
                  final isSelected = currentBrand?.id == brand.id;
                  return _buildFilterChip(
                    context,
                    label: brand.brandName,
                    isSelected: isSelected,
                    onTap: () {
                      tempBrand.value = isSelected ? null : brand;
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          _buildFilterSection<Category>(
            title: '類別',
            items: categories,
            emptyMessage: '無類別資料',
            chipBuilder: (category) {
              return ValueListenableBuilder<Category?>(
                valueListenable: tempCategory,
                builder: (context, currentCategory, _) {
                  final isSelected = currentCategory?.id == category.id;
                  return _buildCategoryFilterChip(
                    label: category.categoryName,
                    category: category,
                    isSelected: isSelected,
                    onTap: () {
                      tempCategory.value = isSelected ? null : category;
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    onApplyFilters(tempStatus.value, tempBrand.value, tempCategory.value);
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text(
                    '確認',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 24),
        ],
      ),
    );
  }

  Widget _buildFilterSection<T>({
    required String title,
    required List<T> items,
    String? emptyMessage,
    required Widget Function(T item) chipBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
        const SizedBox(height: 12),
        if (items.isEmpty && emptyMessage != null)
          Text(
            emptyMessage,
            style: const TextStyle(
              color: Color(0xFF9C9C9C),
              fontSize: 14,
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map(chipBuilder).toList(),
          ),
      ],
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : const Color(0xFFF8F9FA),
          border: Border.all(
            color: isSelected ? primaryColor : const Color(0xFFE5E5E5),
            width: isSelected ? 1.5 : 1.0,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF666666),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusFilterChip({
    required String label,
    required ProductStatus status,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final statusColor = ProductStatusConfig.getColor(status);
    final backgroundColor = isSelected ? statusColor : const Color(0xFFF8F9FA);
    final borderColor = isSelected ? statusColor : statusColor.withValues(alpha: 0.6);
    final textColor = isSelected ? Colors.white : statusColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: isSelected ? 1.5 : 1.0,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: statusColor.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilterChip({
    required String label,
    required Category category,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final categoryColor = Color(category.categoryColor);
    final backgroundColor = isSelected ? categoryColor : const Color(0xFFF8F9FA);
    final borderColor = isSelected ? categoryColor : const Color(0xFFE5E5E5);
    final textColor = isSelected ? Colors.white : const Color(0xFF666666);
    final iconColor = isSelected ? Colors.white : categoryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: isSelected ? 1.5 : 1.0,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: categoryColor.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              getAppIcon(category.categoryIcon),
              size: 16,
              color: iconColor,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
