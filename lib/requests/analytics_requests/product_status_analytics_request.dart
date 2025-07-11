import 'package:collection/collection.dart';

enum ProductStatusAnalyticsType {
  inUse('正常使用', 'inUse'),
  expiring('即將過期', 'expiring'),
  finished('已用完', 'finished'),
  deprecated('過期丟棄', 'deprecated');

  const ProductStatusAnalyticsType(this.displayName, this.value);
  final String displayName;
  final String value;
}

class ProductStatusAnalyticsRequest {
  ProductStatusAnalyticsRequest({
    required this.type,
    required this.count,
  });

  factory ProductStatusAnalyticsRequest.fromJson(Map<String, dynamic> json) {
    return ProductStatusAnalyticsRequest(
      type: ProductStatusAnalyticsType.values.firstWhereOrNull(
        (e) => e.value == json['status_type'] as String,
      ),
      count: json['count'] as int? ?? 0,
    );
  }

  final ProductStatusAnalyticsType? type;
  final int count;
}
