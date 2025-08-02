import Flutter
import UIKit
import flutter_local_notifications
import workmanager

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // This is required to make any communication available in the action isolate.
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60 * 15))

    let bundleId = Bundle.main.bundleIdentifier

    // Register the Workmanager plugin
    WorkmanagerPlugin.registerBGProcessingTask(
      withIdentifier: "\(bundleId).todayExpiryNotification"
    )

    WorkmanagerPlugin.registerPeriodicTask(
      withIdentifier: "\(bundleId).dailyExpireNotificationScheduler", 
      frequency: NSNumber(value: 24 * 60 * 60)
    )

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
