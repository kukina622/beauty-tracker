import 'dart:math';

import 'package:beauty_tracker/constants.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/services/notification_service/notification_service.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:get_it/get_it.dart';

class ExpiryNotificationHandler {
  static Future<bool> handle(Map<String, dynamic>? inputData) async {
    try {
      final authService = GetIt.instance<AuthService>();
      // 檢查用戶是否已登入
      if (!authService.isLoggedIn) {
        return false; // 用戶未登入，不執行通知邏輯
      }

      final productService = GetIt.instance<ProductService>();
      final notificationService = GetIt.instance<NotificationService>();
      final isGranted = await notificationService.requestPermissions();

      if (!isGranted) {
        return false;
      }

      // 獲取即將到期的產品
      final result = await productService.getExpiringSoonProducts();

      switch (result) {
        case Ok(value: final List<Product> expiringProducts):
          if (expiringProducts.isEmpty) {
            return true; // 沒有到期產品，任務成功完成
          }

          // 計算30天內到期的產品數量
          final now = DateTime.now();
          final productsExpiringSoon = expiringProducts.where((Product product) {
            final daysUntilExpiry = product.expiryDate.difference(now).inDays;
            return daysUntilExpiry <= 30 && daysUntilExpiry >= 0;
          }).toList();

          if (productsExpiringSoon.isEmpty) {
            return true;
          }

          // 發送通知
          final count = productsExpiringSoon.length;
          final title = '產品到期提醒';
          final body = '您有 $count 個產品即將在30天內到期';

          await notificationService.showNotification(
            id: Random().nextInt(1000000),
            title: title,
            body: body,
            channelId: NotificationChannels.expiring,
          );

          return true;
        case Err():
          return false;
      }
    } catch (e) {
      return false;
    }
  }
}
