import 'package:beauty_tracker/models/category.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.purchaseDate,
    required this.expiryDate,
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
  final List<Category>? categories;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'purchase_date': purchaseDate.toIso8601String(),
      'expiry_date': expiryDate.toIso8601String(),
      'categories': categories?.map((e) => e.toJson()).toList() ?? [],
    };
  }
}
