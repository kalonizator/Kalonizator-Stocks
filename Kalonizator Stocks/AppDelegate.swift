//
//  AppDelegate.swift
//  Kalonizator Stocks
//
//  Created by Adilet on 30.06.2022.
//

import UIKit
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  lazy var coordinator = makeCoordinator()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    clearNotificationsBadge()
    configureApp()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    coordinator.start()
    window?.makeKeyAndVisible()
    return true
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    NotificationCenter.default.post(
      name: Notification.Name.applicationBecomeActive,
      object: nil
    )
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    NotificationCenter.default.post(
      name: Notification.Name.applicationInBackground,
      object: nil
    )
  }

  private func clearNotificationsBadge() {
    UIApplication.shared.applicationIconBadgeNumber = 0
  }
}


extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {

  // I've added notifications just because it was written in task, but I think there is an error. That's wh
  private func registerNotifications(
    application: UIApplication,
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) {
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
    UNUserNotificationCenter.current().delegate = self
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

    UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
    application.registerForRemoteNotifications()
  }

  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
  }

  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.banner, .badge, .sound])
  }

  func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable: Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
  ) {
    completionHandler(.noData)
  }

  func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable: Any]
  ) {
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
  }
}
