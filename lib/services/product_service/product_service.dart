import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/product_status.dart';

abstract class ProductService {
  Future<Result<void>> getAllProducts();
  Future<Result<void>> getProductById(String productId);
  Future<Result<void>> getProductByStatus(ProductStatus status);
}
