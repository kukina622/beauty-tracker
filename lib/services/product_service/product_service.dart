import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/requests/product_requests/create_product_request.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_status_request.dart';

abstract class ProductService {
  Future<Result<List<Product>>> getAllProducts();
  Future<Result<Product>> getProductById(String productId);
  Future<Result<List<Product>>> getProductByStatus(ProductStatus status);
  Future<Result<List<Product>>> getExpiringSoonProducts();
  Future<Result<Product>> createNewProduct(CreateProductRequest product);
  Future<Result<void>> bulkUpdateProductsStatus(List<UpdateProductStatusRequest> payloads);
}
