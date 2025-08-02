import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/services/auth_service/supabase_auth_service_impl.dart';
import 'package:beauty_tracker/services/background_service/background_service.dart';
import 'package:beauty_tracker/services/background_service/workmanager_background_service_impl.dart';
import 'package:beauty_tracker/services/expiry_notification_record_service/expiry_notification_record_service.dart';
import 'package:beauty_tracker/services/expiry_notification_record_service/supabase_expiry_notification_record_service_impl.dart';
import 'package:beauty_tracker/services/notification_service/flutter_local_notification_service_impl.dart';
import 'package:beauty_tracker/services/notification_service/notification_service.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:beauty_tracker/services/product_service/supabase_product_service_impl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 背景任務依賴管理器
class BackgroundDependencyManager {
  static final GetIt _di = GetIt.instance;

  /// 為背景任務設置最少必要的依賴
  static Future<void> setup() async {
    await _initializeSupabase();
    await _registerServices();
  }

  /// 初始化 Supabase
  static Future<void> _initializeSupabase() async {
    try {
      // 嘗試獲取現有的 Supabase 客戶端
      final _ = Supabase.instance.client;
    } catch (e) {
      await dotenv.load(fileName: '.env');
      final supabaseUrl = dotenv.get('SUPABASE_URL');
      final supabaseKey = dotenv.get('SUPABASE_ANON_KEY');

      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseKey,
      );
    }
  }

  /// 註冊背景任務需要的服務
  static Future<void> _registerServices() async {
    if (!_di.isRegistered<AuthService>()) {
      _di.registerSingleton<AuthService>(SupabaseAuthServiceImpl());
    }

    if (!_di.isRegistered<ProductService>()) {
      _di.registerSingleton<ProductService>(SupabaseProductServiceImpl());
    }

    if (!_di.isRegistered<NotificationService>()) {
      final notificationService = FlutterLocalNotificationServiceImpl();
      await notificationService.initialize();
      _di.registerSingleton<NotificationService>(notificationService);
    }

    if (!_di.isRegistered<ExpiryNotificationRecordService>()) {
      _di.registerSingleton<ExpiryNotificationRecordService>(
        SupabaseExpiryNotificationRecordServiceImpl(),
      );
    }

    if (!_di.isRegistered<BackgroundService>()) {
      final backgroundService = WorkmanagerBackgroundServiceImpl();
      await backgroundService.initialize();
      _di.registerSingleton<BackgroundService>(backgroundService);
    }
  }
}

Future<void> setupBackgroundDependencies() async {
  await BackgroundDependencyManager.setup();
}
