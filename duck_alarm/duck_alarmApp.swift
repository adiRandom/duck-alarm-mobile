//
//  duck_alarmApp.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 14.05.2023.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging
import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
	let navController = NavController()

	func application(_ application: UIApplication,
	                 didFinishLaunchingWithOptions launchOptions: [UIApplication
	                 	.LaunchOptionsKey: Any]?) -> Bool
	{
		FirebaseApp.configure()

		configureFCMPushNotification(application)

		return true
	}

	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		navController.currentRoute = NavController.ALARM
		completionHandler(UIBackgroundFetchResult.newData)
	}
}

extension AppDelegate: MessagingDelegate {
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
		let token = Messaging.messaging().fcmToken
		print("FCM token: \(token ?? "")")
		if let token = token {
			sendTokenToBackend(token: token)
		}
	}

	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		Messaging.messaging().apnsToken = deviceToken
	}

	private func sendTokenToBackend(token: String) {
		let firestore = Firestore.firestore()
		firestore.collection("metadata").document("metadata").updateData(["fcmToken": token])
	}

	func configureFCMPushNotification(_ application: UIApplication) {
		if #available(iOS 10.0, *) {
			// For iOS 10 display notification (sent via APNS)
			UNUserNotificationCenter.current().delegate = self

			let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
			UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
				print(granted)
				print(error)
			}
			Messaging.messaging().delegate = self
		} else {
			let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
		}
		application.registerForRemoteNotifications()
	}
}

@available(iOS 10.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		navController.currentRoute = NavController.ALARM
		completionHandler()
	}

	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		navController.currentRoute = NavController.ALARM
		completionHandler([.alert, .sound, .badge])
	}
}

@main
struct duck_alarmApp: App {
	let persistenceController = Database.shared
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


	var body: some Scene {
		WindowGroup {
				NavRoot()
					.environment(\.managedObjectContext, persistenceController.container.viewContext)
					.environmentObject(delegate.navController)
		}
	}
}
