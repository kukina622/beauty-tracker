class Brand {
  Brand({
    required this.id,
    required this.brandName,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] as String,
      brandName: json['brand_name'] as String,
    );
  }

  final String id;
  final String brandName;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand_name': brandName,
    };
  }
}
