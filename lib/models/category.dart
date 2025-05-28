class Category {
  Category({
    required this.id,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      categoryName: json['category_name'] as String,
      categoryIcon: json['category_icon'] as String,
      categoryColor: json['category_color'] as int,
    );
  }
  final String id;
  final String categoryName;
  final String categoryIcon;
  final int categoryColor;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': categoryName,
      'category_icon': categoryIcon,
      'category_color': categoryColor,
    };
  }
}
