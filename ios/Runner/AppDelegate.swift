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
    GeneratedPluginRegistrant.register(with: self)
    UNUserNotificationCenter.current().delegate = self

    // This is required to make any communication available in the action isolate.
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }

    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }

    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60 * 15))

    // Register the Workmanager plugin
    WorkmanagerPlugin.registerBGProcessingTask(
      withIdentifier: "io.github.kukina622.beautytracker.todayExpiryNotification"
    )

    WorkmanagerPlugin.registerPeriodicTask(
      withIdentifier: "io.github.kukina622.beautytracker.dailyExpireNotificationScheduler", 
      frequency: NSNumber(value: 24 * 60 * 60)
    )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
