import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryFilter extends HookWidget {
  const CategoryFilter({super.key});
  List<String> get categories => const [
        'All',
        'Skincare',
        'Makeup',
        'Haircare',
        'Fragrance',
        'Face',
        'Body',
        'Lips',
        'Eyes',
        'Nails',
        'Sun Care',
        'Cleansers',
        'Treatments',
        'Tools',
        'Masks',
        'Body',
        'Lips',
        'Eyes',
        'Nails',
        'Sun Care',
        'Cleansers',
        'Treatments',
        'Tools',
        'Masks',
        'Serums',
        'Moisturizers',
        'Other'
      ];

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
              final isSelected = category == selectedCategory.value;

              // TODO: Replace with icon mapping or a more dynamic approach
              final Color mainColor = Color(0xFFFF9A9E);

              return GestureDetector(
                onTap: () {
                  selectedCategory.value = category;
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
                        Icons.star, // TODO: map this to a specific icon for each category
                        color: isSelected ? Colors.white : mainColor,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF2D3142),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
