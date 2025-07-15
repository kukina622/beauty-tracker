import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/util/date.dart';
import 'package:beauty_tracker/util/extensions/map.dart';
import 'package:collection/collection.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    this.brand,
    this.price,
    this.purchaseDate,
    required this.expiryDate,
    this.status = ProductStatus.inUse,
    this.categories = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json.getOptionalDouble('price'),
      purchaseDate: json.getOptionalDateTime('purchase_date'),
      expiryDate: DateTime.parse(json['expiry_date'] as String),
      status: ProductStatusConfig.fromValue(json['status'] as String? ?? 'inUse'),
      brand: json['brands'] != null ? Brand.fromJson(json['brands'] as Map<String, dynamic>) : null,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
  final String id;
  final String name;
  final Brand? brand;
  final double? price;
  final DateTime? purchaseDate;
  final DateTime expiryDate;
  final ProductStatus status;
  final List<Category>? categories;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand?.id,
      'price': price,
      'purchase_date': tryFormatDate(purchaseDate),
      'expiry_date': tryFormatDate(expiryDate),
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
