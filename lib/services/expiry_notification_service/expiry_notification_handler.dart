import 'dart:math';

import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/services/notification_service/notification_channel.dart';
import 'package:beauty_tracker/services/notification_service/notification_service.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:get_it/get_it.dart';

class ExpiryNotificationHandler {
  static Future<bool> handle(Map<String, dynamic>? inputData) async {
    try {
      final authService = GetIt.instance<AuthService>();

      if (!authService.isLoggedIn) {
        return false;
      }

      final productService = GetIt.instance<ProductService>();
      final notificationService = GetIt.instance<NotificationService>();

      final result = await productService.getExpiringSoonProducts();

      switch (result) {
        case Ok(value: final List<Product> expiringProducts):
          if (expiringProducts.isEmpty) {
            return true;
          }

          final productNames = expiringProducts.map((product) => product.name).join('、');
          final title = '產品到期提醒';
          final body = '您的美妝品 $productNames 即將到期，請多加留意。';

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
