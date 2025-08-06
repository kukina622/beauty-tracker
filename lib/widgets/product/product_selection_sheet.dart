import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/common/app_search_bar.dart';
import 'package:beauty_tracker/widgets/common/chip/icon_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductSelectionSheet extends HookWidget {
  const ProductSelectionSheet({
    super.key,
    this.onProductSelected,
  });

  final void Function(Product product)? onProductSelected;

  static Future<Product?> show(BuildContext context) async {
    return await showModalBottomSheet<Product>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductSelectionSheet(
        onProductSelected: (product) {
          Navigator.of(context).pop(product);
        },
      ),
    );
  }

  Widget _buildProductImage({required Product product}) {
    final category = product.categories?.firstOrNull;
    final color = Color(category?.categoryColor ?? 0xFFB5EAEA);
    final icon = getAppIcon(category?.categoryIcon);
    return IconChip(
      icon: icon,
      backgroundColor: color.withValues(alpha: .2),
      iconColor: color,
    );
  }

  Widget _buildProductItem(Product product) {
    return InkWell(
      onTap: () => onProductSelected?.call(product),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildProductImage(product: product),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  if (product.brand != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      product.brand!.brandName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent({
    required ServiceDataResult<List<Product>> productsResult,
    required List<Product> filteredProducts,
    required String searchQuery,
  }) {
    // 載入中
    if (productsResult.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 錯誤狀態
    if (productsResult.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              '載入產品失敗',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    // 空狀態
    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery.isNotEmpty ? Icons.search_off : Icons.inbox_outlined,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              searchQuery.isNotEmpty ? '找不到符合的產品' : '沒有可複製的產品',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _buildProductItem(filteredProducts[index]),
            if (index < filteredProducts.length - 1)
              Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productService = useDi<ProductService>();
    final productsResult = useServiceData(() => productService.getAllProducts());
    final allProducts = productsResult.data ?? [];

    final searchQuery = useState<String>('');

    final debouncedSearchQuery = useDebounced(
      searchQuery.value,
      Duration(milliseconds: 500),
    );

    final filteredProducts = useMemoized(() {
      if (debouncedSearchQuery?.isEmpty ?? true) {
        return allProducts;
      }

      return allProducts.where((product) {
        final query = debouncedSearchQuery!.toLowerCase();
        final productName = product.name.toLowerCase();
        final brandName = product.brand?.brandName.toLowerCase() ?? '';

        return productName.contains(query) || brandName.contains(query);
      }).toList();
    }, [allProducts, debouncedSearchQuery]);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '選擇要複製的產品',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AppSearchBar(
              hintText: '搜尋產品名稱或品牌',
              onChanged: (value) => searchQuery.value = value,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildMainContent(
              productsResult: productsResult,
              filteredProducts: filteredProducts,
              searchQuery: searchQuery.value,
            ),
          ),
        ],
      ),
    );
  }
}
