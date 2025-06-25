import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
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
}
