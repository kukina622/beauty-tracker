import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/expiry_notification_record.dart';
import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/services/expiry_notification_record_service/expiry_notification_record_service.dart';
import 'package:beauty_tracker/services/expiry_notification_service/expiry_notification_message.dart';
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
      final expiryNotificationRecordService = GetIt.instance<ExpiryNotificationRecordService>();

      final expiringSoonProductsResult = await productService.getExpiringSoonProducts();
      final notificationRecordsResult =
          await expiryNotificationRecordService.getNotificationRecords();

      final expiringSoonProducts = switch (expiringSoonProductsResult) {
        Ok(value: final List<Product> products) => products,
        Err() => <Product>[],
      };

      final notificationRecords = switch (notificationRecordsResult) {
        Ok(value: final List<ExpiryNotificationRecord> records) => records,
        Err() => <ExpiryNotificationRecord>[],
      };

      if (expiringSoonProducts.isEmpty) {
        return true;
      }

      final today = DateTime.now();

      final Map<ExpiryNotificationType, List<Product>> needNotificationProductsMap = {
        ExpiryNotificationType.today: [],
        ExpiryNotificationType.sevenDays: [],
        ExpiryNotificationType.thirtyDays: [],
      };

      for (final product in expiringSoonProducts) {
        final daysUntilExpiry = product.expiryDate.difference(today).inDays;

        ExpiryNotificationType? targetNotificationType;

        if (daysUntilExpiry <= 0) {
          targetNotificationType = ExpiryNotificationType.today;
        } else if (daysUntilExpiry <= 7) {
          targetNotificationType = ExpiryNotificationType.sevenDays;
        } else if (daysUntilExpiry <= 30) {
          targetNotificationType = ExpiryNotificationType.thirtyDays;
        }

        if (targetNotificationType == null) {
          continue;
        }

        final hasHigherOrSamePriorityNotification = _hasHigherOrSamePriorityNotification(
          notificationRecords,
          product.id,
          targetNotificationType,
        );

        if (hasHigherOrSamePriorityNotification) {
          continue;
        }

        needNotificationProductsMap[targetNotificationType]!.add(product);
      }

      for (final entry in needNotificationProductsMap.entries) {
        final notificationType = entry.key;
        final products = entry.value;

        if (products.isNotEmpty) {
          await _sendNotification(notificationService, products, notificationType);
        }
        // wait for a short period to avoid overwhelming the notification system
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static bool _hasHigherOrSamePriorityNotification(
    List<ExpiryNotificationRecord> sentNotifications,
    String productId,
    ExpiryNotificationType targetType,
  ) {
    final productNotifications =
        sentNotifications.where((notification) => notification.product.id == productId).toList();

    if (targetType == ExpiryNotificationType.thirtyDays) {
      return productNotifications.any((n) =>
          n.notificationType == ExpiryNotificationType.thirtyDays ||
          n.notificationType == ExpiryNotificationType.sevenDays ||
          n.notificationType == ExpiryNotificationType.today);
    }

    if (targetType == ExpiryNotificationType.sevenDays) {
      return productNotifications.any((n) =>
          n.notificationType == ExpiryNotificationType.today ||
          n.notificationType == ExpiryNotificationType.sevenDays);
    }

    if (targetType == ExpiryNotificationType.today) {
      return productNotifications.any((n) => n.notificationType == ExpiryNotificationType.today);
    }

    return false;
  }

  static Future<void> _sendNotification(
    NotificationService notificationService,
    List<Product> product,
    ExpiryNotificationType type,
  ) async {
    final message = ExpiryNotificationMessage.fromType(
      type,
      productName: product.map((p) => p.name).join(', '),
    );

    await notificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch.remainder(999999),
      title: message.title,
      body: message.body,
      channelId: NotificationChannels.expiring,
    );
  }
}
