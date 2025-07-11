class BrandRankAnalyticsRequest {
  BrandRankAnalyticsRequest({
    required this.brandId,
    required this.brandName,
    required this.totalAmount,
    required this.productCount,
  });

  factory BrandRankAnalyticsRequest.fromJson(Map<String, dynamic> json) {
    return BrandRankAnalyticsRequest(
      brandId: json['brand_id'] as String,
      brandName: json['brand_name'] as String,
      totalAmount: (json['total_amount'] as num).toDouble(),
      productCount: json['product_count'] as int,
    );
  }
  final String brandId;
  final String brandName;
  final double totalAmount;
  final int productCount;
}
