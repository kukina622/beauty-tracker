import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/expiry_notification_record.dart';
import 'package:beauty_tracker/requests/expiry_notification_record_requests/create_expiry_notification_record_request.dart';

abstract class ExpiryNotificationRecordService {
  Future<Result<List<ExpiryNotificationRecord>>> getNotificationRecords();
  Future<Result<ExpiryNotificationRecord>> createNewNotificationRecord(
    CreateExpiryNotificationRecordRequest payload,
  );
  Future<Result<List<ExpiryNotificationRecord>>> createMultiNotificationRecords(
    List<CreateExpiryNotificationRecordRequest> payload,
  );

  Future<Result<bool>> hasNotificationBeenSent(
    String productId,
    ExpiryNotificationType notificationType,
  );
}
