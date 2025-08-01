import 'package:beauty_tracker/models/expiry_notification_record.dart';
import 'package:beauty_tracker/models/product.dart';

class CreateExpiryNotificationRecordRequest {
  CreateExpiryNotificationRecordRequest({
    required this.product,
    required this.notificationType,
  });
  Product product;
  ExpiryNotificationType notificationType;

  Map<String, dynamic> toJson() {
    return {
      'product_id': product.id,
      'notification_type': notificationType.value,
    };
  }
}
