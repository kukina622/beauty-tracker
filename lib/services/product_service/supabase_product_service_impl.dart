import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/requests/product_requests/create_product_request.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_request.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_status_request.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:collection/collection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProductServiceImpl implements ProductService {
  SupabaseClient get supabase => Supabase.instance.client;

  @override
  Future<Result<List<Product>>> getAllProducts() async {
    return resultGuard(() async {
      final fetchedProductData = await supabase.from('products').select('*, categories(*)');
      return fetchedProductData.map((item) => Product.fromJson(item)).toList();
    });
  }

  @override
  Future<Result<Product>> getProductById(String productId) {
    return resultGuard(() async {
      final fetchedProductData =
          await supabase.from('products').select('*, categories(*)').eq('id', productId).single();

      return Product.fromJson(fetchedProductData);
    });
  }

  @override
  Future<Result<List<Product>>> getProductByStatus(ProductStatus status) {
    if (status == ProductStatus.all) {
      return getAllProducts();
    }

    return resultGuard(() async {
      final fetchedProductData =
          await supabase.from('products').select('*, categories(*)').eq('status', status.value);
      return fetchedProductData.map((item) => Product.fromJson(item)).toList();
    });
  }

  @override
  Future<Result<List<Product>>> getExpiringSoonProducts() {
    return resultGuard(() async {
      final fetchedProductData =
          await supabase.from('products_in_use_expiring_in_30d').select('*, categories(*)');
      return fetchedProductData.map((item) => Product.fromJson(item)).toList();
    });
  }

  @override
  Future<Result<Product>> createNewProduct(CreateProductRequest product) {
    return resultGuard(() async {
      final productMap = product.toJsonWithoutCategories();

      final newProduct = await supabase.from('products').upsert(productMap).select();

      if (newProduct.isEmpty) {
        throw Exception('Failed to create new product');
      }

      final productId = newProduct.first['id'] as String;
      if (product.categories.isNotEmpty) {
        final categoryIds = product.categories;

        await supabase.from('product_category').insert(
              categoryIds
                  .map((categoryId) => {'product_id': productId, 'category_id': categoryId})
                  .toList(),
            );
      }

      final fetchedProductData =
          await supabase.from('products').select('*, categories(*)').eq('id', productId).single();

      return Product.fromJson(fetchedProductData);
    });
  }

  @override
  Future<Result<Product>> updateProduct(String productId, UpdateProductRequest payload) {
    return resultGuard(() async {
      final productMap = payload.toJsonWithoutCategories();

      await supabase.from('products').update(productMap).eq('id', productId);

      await supabase.from('product_category').delete().eq('product_id', productId);

      if (payload.categories.isNotEmpty) {
        await supabase.from('product_category').insert(
              payload.categories
                  .map((categoryId) => {'product_id': productId, 'category_id': categoryId})
                  .toList(),
            );
      }

      final fetchedProductData =
          await supabase.from('products').select('*, categories(*)').eq('id', productId).single();

      return Product.fromJson(fetchedProductData);
    });
  }

  @override
  Future<Result<void>> bulkUpdateProductsStatus(List<UpdateProductStatusRequest> payloads) async {
    return resultGuard(() async {
      final List<String> productIds = payloads.map((e) => e.productId).toList();
      final fetchedProductMap =
          await supabase.from('products').select('*').inFilter('id', productIds);

      final fetchedProductData = fetchedProductMap.map((item) => Product.fromJson(item)).toList();

      for (final payload in payloads) {
        final originProduct = fetchedProductData.firstWhereOrNull((p) => p.id == payload.productId);

        if (originProduct == null || originProduct.status.value == payload.status.value) {
          continue;
        }

        await supabase
            .from('products')
            .update({'status': payload.status.value}).eq('id', payload.productId);
      }
    });
  }

  @override
  Future<Result<void>> deleteProduct(String productId) async {
    return resultGuard(() async {
      final products = await supabase.from('products').select().eq('id', productId);
      if (products.isEmpty) {
        throw Exception('Product not found');
      }
      await supabase.from('product_category').delete().eq('product_id', productId);
      await supabase.from('products').delete().eq('id', productId);
    });
  }
}
