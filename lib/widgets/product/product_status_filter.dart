import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/widgets/common/app_card.dart';
import 'package:beauty_tracker/widgets/common/chip/chip_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductStatusFilter extends HookWidget {
  const ProductStatusFilter({
    super.key,
    this.initialStatus = ProductStatus.inUse,
    this.onStatusChanged,
  });

  final ProductStatus initialStatus;
  final void Function(ProductStatus)? onStatusChanged;

  List<ChipData<ProductStatus>> get statusChips {
    return ProductStatusConfig.getAllStatuses()
        .map((status) => ChipData(
              label: status.displayName,
              value: status,
              icon: ProductStatusConfig.getIcon(status),
              color: ProductStatusConfig.getColor(status),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedStatus = useState(initialStatus);

    return AppCard(
      height: 44,
      width: double.infinity,
      borderRadius: BorderRadius.circular(22),
      child: ChipGroup(
        chips: statusChips,
        onSelected: (value) {
          selectedStatus.value = value;
          if (onStatusChanged != null) {
            onStatusChanged!(value);
          }
        },
        defaultValue: ProductStatus.inUse,
      ),
    );
  }
}
