import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_easy_loading.dart';
import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/category/category_chip.dart';
import 'package:beauty_tracker/widgets/common/app_card.dart';
import 'package:beauty_tracker/widgets/common/chip/icon_chip.dart';
import 'package:beauty_tracker/widgets/common/chip/text_icon_chip.dart';
import 'package:beauty_tracker/widgets/common/dialog/delete_dialog.dart';
import 'package:beauty_tracker/widgets/common/icon_button/app_standard_icon_button.dart';
import 'package:beauty_tracker/widgets/product/expiring_chip.dart';
import 'package:beauty_tracker/widgets/product/selectable_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductCard extends HookWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.isEditStatusMode = false,
    this.onStatusChanged,
    this.onDelete,
  });
  final Product product;
  final bool isEditStatusMode;
  final void Function(ProductStatus status)? onStatusChanged;
  final void Function()? onDelete;

  List<ProductStatus> get availableStatuses {
    return ProductStatusConfig.getAllStatuses()
        .where((status) => status != ProductStatus.all)
        .toList();
  }

  Widget _buildProductImage({Category? category}) {
    final color = Color(category?.categoryColor ?? 0xFFB5EAEA);
    final icon = getAppIcon(category?.categoryIcon);
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
        ],
      ),
    );
  }

  Widget _buildProductActions({
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
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
      ],
    );
  }

  Widget _buildProductBrand(BuildContext context, {Brand? brand}) {
    if (brand == null) {
      return const SizedBox.shrink();
    }

    return Row(children: [
      Icon(
        Icons.workspace_premium_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
      SizedBox(width: 8),
      Flexible(
        child: Text(
          brand.brandName,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
    ]);
  }

  Widget _buildProductReminder() {
    return ExpiringChip(expiryDate: product.expiryDate);
  }

  Widget _buildProductCategory({List<Category>? categories = const []}) {
    if (categories?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
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

  Widget _buildProductStatusBar({
    required ProductStatus status,
    bool isEditStatusMode = false,
    void Function(ProductStatus status)? onStatusChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(
              '狀態:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isEditStatusMode
                  ? SelectableStatusBar(
                      status: status,
                      onStatusChanged: onStatusChanged,
                    )
                  : _buildReadonlyStatusChip(status: status),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadonlyStatusChip({required ProductStatus status}) {
    return TextIconChip(
      text: status.displayName,
      icon: ProductStatusConfig.getIcon(status),
      iconColor: ProductStatusConfig.getColor(status),
      textColor: ProductStatusConfig.getColor(status),
      backgroundColor: ProductStatusConfig.getColor(status).withValues(alpha: .2),
      borderColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productService = useDi<ProductService>();
    final easyLoading = useEasyLoading();

    final onDeleteProduct = useCallback(() async {
      final result = await productService.deleteProduct(product.id);
      switch (result) {
        case Ok():
          easyLoading.showSuccess('刪除成功');
          if (context.mounted) {
            AutoRouter.of(context).pop();
          }
          onDelete?.call();
          break;
        case Err():
          easyLoading.showError('刪除失敗');
          break;
      }
    }, [productService, product.id]);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProductImage(
                  category: product.categories?.firstOrNull,
                ),
                const SizedBox(width: 16),
                _buildProductInfo(
                  name: product.name,
                ),
                _buildProductActions(
                  onEdit: () {
                    AutoRouter.of(context).pushPath('/product/edit/${product.id}');
                  },
                  onDelete: () {
                    DeleteDialog.show(
                      context,
                      title: '刪除美妝品',
                      description: '你確定要刪除"${product.name}"嗎？\n這個操作不能復原',
                      onConfirm: onDeleteProduct,
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildProductBrand(context, brand: product.brand),
                ),
                SizedBox(width: 8),
                _buildProductReminder(),
              ],
            ),
          ),
          _buildProductCategory(
            categories: product.categories,
          ),
          _buildProductStatusBar(
            status: product.status,
            isEditStatusMode: isEditStatusMode,
            onStatusChanged: onStatusChanged,
          ),
        ],
      ),
    );
  }
}
