import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_status_requests.dart';
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
    // TODO: implement getProductById
    throw UnimplementedError();
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
  Future<Result<void>> bulkUpdateProductsStatus(List<UpdateProductStatusRequests> payloads) async {
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
}
