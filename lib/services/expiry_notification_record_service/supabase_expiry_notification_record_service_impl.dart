import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/expiry_notification_record.dart';
import 'package:beauty_tracker/requests/expiry_notification_record_requests/create_expiry_notification_record_request.dart';
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
  Future<Result<ExpiryNotificationRecord>> createNewNotificationRecord(
    CreateExpiryNotificationRecordRequest payload,
  ) async {
    return resultGuard(() async {
      final insertedRecord = await supabase
          .from('expiry_notification_records')
          .insert(payload.toJson())
          .select()
          .single();

      return ExpiryNotificationRecord.fromJson(insertedRecord);
    });
  }

  @override
  Future<Result<List<ExpiryNotificationRecord>>> createMultiNotificationRecords(
    List<CreateExpiryNotificationRecordRequest> payload,
  ) {
    return resultGuard(() async {
      final insertedRecords = await supabase
          .from('expiry_notification_records')
          .insert(payload.map((e) => e.toJson()).toList())
          .select();

      if (insertedRecords.isEmpty) {
        throw Exception('Failed to insert notification records');
      }

      return insertedRecords.map((e) => ExpiryNotificationRecord.fromJson(e)).toList();
    });
  }
}
