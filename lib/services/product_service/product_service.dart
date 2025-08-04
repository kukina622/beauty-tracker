import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/requests/product_requests/create_product_request.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_request.dart';
import 'package:beauty_tracker/requests/product_requests/update_product_status_request.dart';

abstract class ProductService {
  Future<Result<List<Product>>> getAllProducts();
  Future<Result<Product>> getProductById(String productId);
  Future<Result<List<Product>>> getProductByStatus(ProductStatus status);
  Future<Result<List<Product>>> getProductsWithFilters({
    ProductStatus? status,
    String? brandId,
    String? categoryId,
  });
  Future<Result<List<Product>>> getExpiringSoonProducts();
  Future<Result<Product>> createNewProduct(CreateProductRequest product);
  Future<Result<Product>> updateProduct(String productId, UpdateProductRequest product);
  Future<Result<void>> bulkUpdateProductsStatus(List<UpdateProductStatusRequest> payloads);
  Future<Result<void>> deleteProduct(String productId);
}
