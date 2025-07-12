import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/widgets/brand/brand_selector/brand_selector_item.dart';
import 'package:beauty_tracker/widgets/brand/dialogs/brand_form_dialog.dart';
import 'package:beauty_tracker/widgets/common/button/app_outlined_button.dart';
import 'package:beauty_tracker/widgets/common/sheet/selection_sheet/selection_sheet.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class BrandSelectionSheet {
  static Future<void> show(
    BuildContext context, {
    required List<Brand> allBrands,
    String? initialSelectedId,
    required void Function(List<String>) onConfirmed,
    void Function(Brand)? onBrandCreated,
  }) {
    final initialSelectedBrands = initialSelectedId == null
        ? List<Brand>.empty()
        : allBrands.where((brand) => initialSelectedId == brand.id).toList();

    return SelectionSheet.show<Brand>(
      context,
      title: '選擇品牌',
      allItems: allBrands,
      initialSelectedItems: initialSelectedBrands,
      allowMultipleSelection: false,
      onConfirmed: (selectedBrands) {
        final selectedIds = selectedBrands.map((c) => c.id).toList();
        onConfirmed(selectedIds);
      },
      itemBuilder: (brand, isSelected, onSelected) => BrandSelectorItem(
        brand: brand,
        isSelected: isSelected,
        onSelected: onSelected,
      ),
      bottomActionWidget: AppOutlinedButton(
        isFilled: true,
        text: '加入新品牌',
        icon: Icons.add_circle_outline,
        onPressed: () {
          BrandFormDialog.showCreate(
            context,
            onBrandCreated: (brand) {
              onBrandCreated?.call(brand);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
