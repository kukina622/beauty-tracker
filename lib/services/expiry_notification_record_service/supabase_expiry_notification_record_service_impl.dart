import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/expiry_notification_record.dart';
import 'package:beauty_tracker/services/expiry_notification_record_service/expiry_notification_record_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseExpiryNotificationRecordServiceImpl implements ExpiryNotificationRecordService {
  SupabaseClient get supabase => Supabase.instance.client;

  @override
  Future<Result<List<ExpiryNotificationRecord>>> getNotificationRecords() async {
    return resultGuard(() async {
      final fetchedData = await supabase
          .from('expiry_notification_records')
          .select('*, products(*, categories(*), brands(*))')
          .order('sent_date', ascending: false);

      return fetchedData.map((e) => ExpiryNotificationRecord.fromJson(e)).toList();
    });
  }

  @override
  Future<Result<void>> createNewNotificationRecord(
    String productId,
    ExpiryNotificationType notificationType,
  ) async {
    return resultGuard(() async {});
  }

  @override
  Future<Result<bool>> hasNotificationBeenSent(
    String productId,
    ExpiryNotificationType notificationType,
  ) async {
    return resultGuard(() async {
      return false;
    });
  }
}
