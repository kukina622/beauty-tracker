import 'package:beauty_tracker/services/background_service/task_keys.dart';
import 'package:beauty_tracker/services/background_service/task_registry.dart';
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
    await _registerTaskHandlers();
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
    if (!_di.isRegistered<ProductService>()) {
      _di.registerSingleton<ProductService>(SupabaseProductServiceImpl());
    }

    if (!_di.isRegistered<NotificationService>()) {
      final notificationService = FlutterLocalNotificationServiceImpl();
      await notificationService.initialize();
      _di.registerSingleton<NotificationService>(notificationService);
    }
  }

  /// 註冊背景任務處理器
  static Future<void> _registerTaskHandlers() async {
    TaskRegistry().registerTaskHandler(
      TaskKeys.expireNotifications,
      (_) async {
        print('Handling expire notifications task');
        return true;
      },
    );
  }
}

/// 向後兼容的函數（保持現有的 API）
Future<void> setupBackgroundDependencies() async {
  await BackgroundDependencyManager.setup();
}
