import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/expiry_notification_record.dart';

abstract class ExpiryNotificationRecordService {
  Future<Result<List<ExpiryNotificationRecord>>> getNotificationRecords();
  Future<Result<void>> createNewNotificationRecord(
    String productId,
    ExpiryNotificationType notificationType,
  );
  Future<Result<bool>> hasNotificationBeenSent(
    String productId,
    ExpiryNotificationType notificationType,
  );
}
