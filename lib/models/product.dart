import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:collection/collection.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.purchaseDate,
    required this.expiryDate,
    this.status = ProductStatus.inUse,
    this.categories = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      purchaseDate: DateTime.parse(json['purchase_date'] as String),
      expiryDate: DateTime.parse(json['expiry_date'] as String),
      status: ProductStatusConfig.fromValue(json['status'] as String? ?? 'inUse'),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
  final String id;
  final String name;
  final String brand;
  final double price;
  final DateTime purchaseDate;
  final DateTime expiryDate;
  final ProductStatus status;
  final List<Category>? categories;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'purchase_date': purchaseDate.toIso8601String(),
      'expiry_date': expiryDate.toIso8601String(),
      'status': status.value,
      'categories': categories?.map((e) => e.toJson()).toList() ?? [],
    };
  }

  static List<Product> sortByExpiryDate(List<Product> products) {
    final DateTime now = DateTime.now();
    return products.sorted((a, b) {
      final aExpiry = a.expiryDate.difference(now).inDays;
      final bExpiry = b.expiryDate.difference(now).inDays;
      return aExpiry.compareTo(bExpiry);
    });
  }
}
