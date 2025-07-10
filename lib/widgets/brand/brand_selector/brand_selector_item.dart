import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/widgets/common/sheet/selection_sheet/selector_item.dart';
import 'package:flutter/material.dart';

class BrandSelectorItem extends StatelessWidget {
  const BrandSelectorItem({
    super.key,
    required this.brand,
    this.isSelected = false,
    this.onSelected,
  });

  final Brand brand;
  final bool isSelected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return SelectorItem<Brand>(
      item: brand,
      title: brand.brandName,
      isSelected: isSelected,
      onSelected: (_) => onSelected?.call(),
    );
  }
}
