import 'package:flutter/material.dart';

enum ProductStatus {
  all('全部', 'all'),
  inUse('使用中', 'inUse'),
  finished('已用完', 'finished'),
  expired('過期丟棄', 'expired');

  const ProductStatus(this.displayName, this.value);
  final String displayName;
  final String value;
}

class ProductStatusConfig {
  ProductStatusConfig._();

  static const Map<ProductStatus, Color> _statusColors = {
    ProductStatus.all: Color(0xFFFF9999),
    ProductStatus.inUse: Color(0xFF5ECCC4),
    ProductStatus.finished: Color(0xFFFFB347),
    ProductStatus.expired: Color(0xFF9E9E9E),
  };

  static const Map<ProductStatus, IconData> _statusIcons = {
    ProductStatus.all: Icons.all_inclusive,
    ProductStatus.inUse: Icons.check_circle_outline_rounded,
    ProductStatus.finished: Icons.done_all_rounded,
    ProductStatus.expired: Icons.delete_outline_rounded,
  };

  static Color getColor(ProductStatus status) => _statusColors[status] ?? Colors.grey;
  static IconData getIcon(ProductStatus status) => _statusIcons[status] ?? Icons.help;

  static ProductStatus? fromStatusString(String statusString) {
    for (final ProductStatus status in ProductStatus.values) {
      if (status.displayName == statusString) {
        return status;
      }
    }
    return null;
  }

  static ProductStatus fromValue(String value) {
    return ProductStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => ProductStatus.all,
    );
  }

  static List<ProductStatus> getAllStatuses() => ProductStatus.values;
}
