import 'package:beauty_tracker/util/date.dart';

class UpdateProductRequest {
  UpdateProductRequest({
    required this.name,
    this.brand,
    this.price,
    this.purchaseDate,
    this.expiryDate,
    this.categories = const [],
  });
  final String name;
  final String? brand;
  final double? price;
  final DateTime? purchaseDate;
  final DateTime? expiryDate;
  final List<String> categories;

  Map<String, dynamic> toJsonWithoutCategories() {
    return {
      'name': name,
      'brand': brand,
      'price': price,
      'purchase_date': tryFormatDate(purchaseDate),
      'expiry_date': tryFormatDate(expiryDate),
    };
  }
}
