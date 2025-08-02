import 'package:beauty_tracker/services/analytics_service/analytics_service.dart';
import 'package:beauty_tracker/services/analytics_service/supabase_analytics_service_impl.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:beauty_tracker/services/auth_service/supabase_auth_service_impl.dart';
import 'package:beauty_tracker/services/background_service/background_service.dart';
import 'package:beauty_tracker/services/background_service/workmanager_background_service_impl.dart';
import 'package:beauty_tracker/services/brand_service/brand_service.dart';
import 'package:beauty_tracker/services/brand_service/supabase_brand_service_impl.dart';
import 'package:beauty_tracker/services/category_service/category_service.dart';
import 'package:beauty_tracker/services/category_service/supabase_category_service_impl.dart';
import 'package:beauty_tracker/services/expiry_notification_record_service/expiry_notification_record_service.dart';
import 'package:beauty_tracker/services/expiry_notification_record_service/supabase_expiry_notification_record_service_impl.dart';
import 'package:beauty_tracker/services/expiry_notification_service/expiry_notification_service.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_service.dart';
import 'package:beauty_tracker/services/local_storage_service/shared_preferences_local_storage_service_impl.dart';
import 'package:beauty_tracker/services/notification_service/flutter_local_notification_service_impl.dart';
import 'package:beauty_tracker/services/notification_service/notification_service.dart';
import 'package:beauty_tracker/services/product_service/product_service.dart';
import 'package:beauty_tracker/services/product_service/supabase_product_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final di = GetIt.instance;

class AppInitializer {
  static Future<void> initialize() async {
    await _loadEnvironment();
    await _initializeSupabase();
    _setupDependencyInjection();
    _configureEasyLoading();
    await _initializeServices();
    await _requestPermissions();
    await _initializeDefaultLocalStorageValue();
  }

  static Future<void> _loadEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static Future<void> _initializeSupabase() async {
    final supabaseUrl = dotenv.get('SUPABASE_URL');
    final supabaseKey = dotenv.get('SUPABASE_ANON_KEY');

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
  }

  static void _setupDependencyInjection() {
    di.registerSingleton<AuthService>(SupabaseAuthServiceImpl());
    di.registerSingleton<LocalStorageService>(
      SharedPreferencesLocalStorageServiceImpl(),
    );

    di.registerSingleton<ProductService>(SupabaseProductServiceImpl());
    di.registerSingleton<CategoryService>(SupabaseCategoryServiceImpl());
    di.registerSingleton<BrandService>(SupabaseBrandServiceImpl());
    di.registerSingleton<AnalyticsService>(SupabaseAnalyticsServiceImpl());
    di.registerSingleton<ExpiryNotificationRecordService>(
      SupabaseExpiryNotificationRecordServiceImpl(),
    );

    di.registerSingleton<NotificationService>(
      FlutterLocalNotificationServiceImpl(),
    );

    di.registerSingleton<BackgroundService>(
      WorkmanagerBackgroundServiceImpl(),
    );

    di.registerSingleton<ExpiryNotificationService>(
      ExpiryNotificationService(
        backgroundService: di<BackgroundService>(),
      ),
    );
  }

  static void _configureEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Color(0xFFFFA5B1)
      ..backgroundColor = Colors.white
      ..indicatorColor = Color(0xFFFFA5B1)
      ..textColor = Colors.black
      ..maskColor = Colors.black.withValues(alpha: .5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static Future<void> _initializeServices() async {
    final notificationService = di<NotificationService>();
    await notificationService.initialize();

    final backgroundService = di<BackgroundService>();
    await backgroundService.initialize();

    final expiryNotificationService = di<ExpiryNotificationService>();
    await expiryNotificationService.initialize();
  }

  static Future<void> _requestPermissions() async {
    final notificationService = di<NotificationService>();
    await notificationService.requestPermissions();
  }

  static Future<void> _initializeDefaultLocalStorageValue() async {
    final localStorageService = di<LocalStorageService>();
    final isFirstVisit = await localStorageService.getBool(LocalStorageKeys.isFirstVisit);

    if (isFirstVisit == null) {
      await localStorageService.setBool(LocalStorageKeys.isFirstVisit, true);
    }

    final rememberUserEmail = await localStorageService.getBool(LocalStorageKeys.userEmail);
    if (rememberUserEmail == null) {
      await localStorageService.setBool(LocalStorageKeys.userEmail, false);
    }

    // Initialize default notification settings
    final thirtyDayExpiryNotificationEnabled = await localStorageService.getBool(
      LocalStorageKeys.thirtyDayExpiryNotificationEnabled,
    );
    if (thirtyDayExpiryNotificationEnabled == null) {
      await localStorageService.setBool(LocalStorageKeys.thirtyDayExpiryNotificationEnabled, true);
    }

    final sevenDayExpiryNotificationEnabled = await localStorageService.getBool(
      LocalStorageKeys.sevenDayExpiryNotificationEnabled,
    );
    if (sevenDayExpiryNotificationEnabled == null) {
      await localStorageService.setBool(LocalStorageKeys.sevenDayExpiryNotificationEnabled, true);
    }

    final todayExpiryNotificationEnabled = await localStorageService.getBool(
      LocalStorageKeys.todayExpiryNotificationEnabled,
    );
    if (todayExpiryNotificationEnabled == null) {
      await localStorageService.setBool(LocalStorageKeys.todayExpiryNotificationEnabled, true);
    }
  }
}
