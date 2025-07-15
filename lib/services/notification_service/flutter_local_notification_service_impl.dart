import 'dart:io';

import 'package:beauty_tracker/constants.dart';
import 'package:beauty_tracker/services/notification_service/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlutterLocalNotificationServiceImpl implements NotificationService {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  Future<void> initialize() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');

    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Future<bool> requestPermissions() async {
    final androidResult = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    final iosResult = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    if (Platform.isAndroid) {
      return androidResult ?? false;
    }

    if (Platform.isIOS) {
      return iosResult ?? false;
    }

    return false;
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? channelId,
  }) async {
    final selectedChannelId = channelId ?? NotificationChannels.general;
    final channelInfo = NotificationChannels.channelInfo[selectedChannelId];

    if (channelInfo == null) {
      throw ArgumentError('Invalid channel ID: $selectedChannelId');
    }

    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channelInfo.id,
      channelInfo.name,
      channelDescription: channelInfo.description,
      importance: channelInfo.importance,
      icon: '@drawable/ic_notification',
    );

    final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
