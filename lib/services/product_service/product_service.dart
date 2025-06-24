import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';

abstract class ProductService {
  Future<Result<List<Product>>> getAllProducts();
  Future<Result<Product>> getProductById(String productId);
  Future<Result<List<Product>>> getProductByStatus(ProductStatus status);
}
