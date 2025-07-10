class CreateBrandRequest {
  CreateBrandRequest({required this.brandName});

  final String brandName;

  Map<String, dynamic> toJson() {
    return {
      'brand_name': brandName,
    };
  }
}
