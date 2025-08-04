import 'package:beauty_tracker/models/product_status.dart';
import 'package:beauty_tracker/widgets/common/chip/chip_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SelectableStatusBar extends HookWidget {
  const SelectableStatusBar({super.key, required this.status, this.onStatusChanged});
  final ProductStatus status;
  final void Function(ProductStatus)? onStatusChanged;

  List<ProductStatus> get availableStatuses {
    return ProductStatusConfig.getAllStatuses()
        .where((status) => status != ProductStatus.all)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedStatus = useState<ProductStatus>(status);

    final chips = availableStatuses.map((status) {
      final color = ProductStatusConfig.getColor(status);
      return ChipData(
        label: status.displayName,
        value: status,
        color: color,
        icon: ProductStatusConfig.getIcon(status),
        border: Border.all(
          color: selectedStatus.value == status ? color : Colors.grey.shade300,
          width: 1,
        ),
      );
    }).toList();

    return ChipGroup(
      chips: chips,
      iconSize: 14,
      fontSize: 12,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      selectedValue: status,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      onSelected: (value) {
        selectedStatus.value = value;
        if (onStatusChanged != null) {
          onStatusChanged!(value);
        }
      },
    );
  }
}
