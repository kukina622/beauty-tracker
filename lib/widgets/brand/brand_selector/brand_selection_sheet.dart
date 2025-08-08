import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/widgets/brand/brand_selector/brand_selector_item.dart';
import 'package:beauty_tracker/widgets/brand/dialogs/brand_form_dialog.dart';
import 'package:beauty_tracker/widgets/common/button/app_outlined_button.dart';
import 'package:beauty_tracker/widgets/common/sheet/selection_sheet/selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BrandSelectionSheet extends HookWidget {
  const BrandSelectionSheet({
    super.key,
    required this.allBrands,
    this.initialSelectedId,
    required this.onConfirmed,
    this.onBrandCreated,
  });

  final List<Brand> allBrands;
  final String? initialSelectedId;
  final void Function(List<String>) onConfirmed;
  final void Function(Brand)? onBrandCreated;

  static Future<void> show(
    BuildContext context, {
    required List<Brand> allBrands,
    String? initialSelectedId,
    required void Function(List<String>) onConfirmed,
    void Function(Brand)? onBrandCreated,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BrandSelectionSheet(
        allBrands: allBrands,
        initialSelectedId: initialSelectedId,
        onConfirmed: onConfirmed,
        onBrandCreated: onBrandCreated,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initialSelectedBrands = initialSelectedId == null
        ? List<Brand>.empty()
        : allBrands.where((brand) => initialSelectedId == brand.id).toList();

    final brands = useState<List<Brand>>(allBrands);

    return SelectionSheet<Brand>(
      title: '選擇品牌',
      allItems: brands.value,
      initialSelectedItems: initialSelectedBrands,
      allowMultipleSelection: false,
      isSearchable: true,
      onSearchChanged: (query) {
        brands.value = allBrands
            .where((brand) => brand.brandName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
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
