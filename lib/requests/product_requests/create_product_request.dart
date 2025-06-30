import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/util/date.dart';

class CreateProductRequest {
  CreateProductRequest({
    required this.name,
    this.brand,
    this.price,
    this.purchaseDate,
    this.expiryDate,
    this.status = ProductStatus.inUse,
    this.categories = const [],
  });
  final String name;
  final String? brand;
  final double? price;
  final DateTime? purchaseDate;
  final DateTime? expiryDate;
  final ProductStatus status;
  final List<String> categories;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand': brand,
      'price': price,
      'purchase_date': tryFormatDate(purchaseDate!),
      'expiry_date': tryFormatDate(expiryDate!),
      'status': status.value,
      'categories': categories,
    };
  }

  Map<String, dynamic> toJsonWithoutCategories() {
    return {
      'name': name,
      'brand': brand,
      'price': price,
      'purchase_date': tryFormatDate(purchaseDate),
      'expiry_date': tryFormatDate(expiryDate),
      'status': status.value,
    };
  }
}
