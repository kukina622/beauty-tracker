import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/common/app_card.dart';
import 'package:beauty_tracker/widgets/common/chip/chip_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryFilter extends HookWidget {
  const CategoryFilter({super.key, this.categories = const []});
  final List<Category> categories;

  List<ChipData<String>> get categoryChips {
    return categories
        .map((category) => ChipData(
              label: category.categoryName,
              value: category.id,
              icon: getIcon(category.categoryIcon),
              color: Color(category.categoryColor),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> selectedCategory = useState('All');

    return AppCard(
      height: 44,
      width: double.infinity,
      borderRadius: BorderRadius.circular(22),
      child: ChipGroup(
        chips: categoryChips,
        onSelected: (value) {
          selectedCategory.value = value;
        },
        defaultValue: selectedCategory.value,
      ),
    );
  }
}
