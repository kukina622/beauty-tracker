import 'package:beauty_tracker/requests/analytics_requests/product_status_analytics_request.dart';
import 'package:beauty_tracker/widgets/analytics/status_progress_chart.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AnalyticsUtils {
  static List<StatusProgressData> convertToStatusList(
    List<ProductStatusAnalyticsRequest> analyticsData,
  ) {
    final Map<ProductStatusAnalyticsType, Color> statusColors = {
      ProductStatusAnalyticsType.inUse: const Color(0xFF5ECCC4),
      ProductStatusAnalyticsType.expiring: const Color(0xFFFF9F1C),
      ProductStatusAnalyticsType.deprecated: const Color(0xFFFF6B6B),
      ProductStatusAnalyticsType.finished: const Color(0xFFBDBDBD),
    };

    final List<ProductStatusAnalyticsType> displayOrder = [
      ProductStatusAnalyticsType.inUse, // 正常使用
      ProductStatusAnalyticsType.expiring, // 即將過期
      ProductStatusAnalyticsType.deprecated, // 過期丟棄
      ProductStatusAnalyticsType.finished, // 已用完
    ];

    final Map<ProductStatusAnalyticsType, int> dataMap = {};
    for (final item in analyticsData) {
      if (item.type != null) {
        dataMap[item.type!] = item.count;
      }
    }

    return displayOrder.map((type) {
      final count = dataMap[type] ?? 0; // 如果沒有資料則顯示 0
      return StatusProgressData(
        status: type.displayName,
        count: count,
        color: statusColors[type]!,
      );
    }).toList();
  }
}
