import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_status_requests.dart';

abstract class ProductService {
  Future<Result<List<Product>>> getAllProducts();
  Future<Result<Product>> getProductById(String productId);
  Future<Result<List<Product>>> getProductByStatus(ProductStatus status);
  Future<Result<void>> bulkUpdateProductsStatus(List<UpdateProductStatusRequests> payloads);
}
