class CreateCategoryRequest {
  CreateCategoryRequest({
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
  });
  final String categoryName;
  final int categoryIcon;
  final int categoryColor;

  Map<String, dynamic> toJson() {
    return {
      'category_name': categoryName,
      'category_icon': categoryIcon,
      'category_color': categoryColor,
    };
  }
}
