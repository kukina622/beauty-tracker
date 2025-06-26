import 'package:beauty_tracker/models/product_status.dart';

class UpdateProductStatusRequests {
  UpdateProductStatusRequests({
    required this.productId,
    required this.status,
  });
  final String productId;
  final ProductStatus status;
}
