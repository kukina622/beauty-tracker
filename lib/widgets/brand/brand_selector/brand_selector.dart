import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/widgets/brand/brand_selector/brand_selection_sheet.dart';
import 'package:flutter/material.dart';

class BrandSelector extends StatelessWidget {
  const BrandSelector({
    super.key,
    this.allBrands = const [],
    this.selectedBrandId,
    this.onBrandSelected,
    this.onBrandCreated,
  });
  final List<Brand> allBrands;
  final String? selectedBrandId;
  final void Function(List<String>)? onBrandSelected;
  final void Function(Brand)? onBrandCreated;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BrandSelectionSheet.show(
          context,
          allBrands: allBrands,
          initialSelectedId: selectedBrandId,
          onConfirmed: (selectedIds) {
            onBrandSelected?.call(selectedIds);
          },
          onBrandCreated: onBrandCreated,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '選擇品牌',
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF2D3142),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF2D3142),
            ),
          ],
        ),
      ),
    );
  }
}
