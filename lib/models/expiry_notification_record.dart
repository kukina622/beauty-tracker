import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/util/date.dart';
import 'package:collection/collection.dart';

enum ExpiryNotificationType {
  thirtyDays('30_days'),
  sevenDays('7_days'),
  today('today');

  const ExpiryNotificationType(this.value);
  final String value;
}

class ExpiryNotificationRecord {
  ExpiryNotificationRecord({
    required this.id,
    required this.product,
    required this.notificationType,
    required this.sentDate,
  });

  factory ExpiryNotificationRecord.fromJson(Map<String, dynamic> json) {
    return ExpiryNotificationRecord(
      id: json['id'] as String,
      product: Product.fromJson(json['products'] as Map<String, dynamic>),
      notificationType: ExpiryNotificationType.values.firstWhereOrNull(
        (type) => type.value == json['notification_type'] as String,
      ),
      sentDate: DateTime.parse(json['sent_date'] as String),
    );
  }

  final String id;
  final Product product;
  final ExpiryNotificationType? notificationType;
  final DateTime sentDate;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': product.id,
      'notificationType': notificationType?.value ?? '',
      'sentDate': tryFormatDate(sentDate),
    };
  }
}
