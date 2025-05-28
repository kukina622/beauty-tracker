import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryFilter extends HookWidget {
  const CategoryFilter({super.key, this.categories = const []});
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> selectedCategory = useState('All');

    return Container(
      height: 44,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              final isSelected = category.id == selectedCategory.value;
              final Color mainColor = Color(category.categoryColor);
              return GestureDetector(
                onTap: () {
                  selectedCategory.value = category.id;
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [mainColor, mainColor.withValues(alpha: 0.8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        getIcon(category.categoryIcon),
                        color: isSelected ? Colors.white : mainColor,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        category.categoryName,
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF2D3142),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
