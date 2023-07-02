//
//  duck_alarmApp.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 14.05.2023.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
				   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
	FirebaseApp.configure()
	return true
  }
}

@main
struct duck_alarmApp: App {
    let persistenceController = Database.shared
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
//			DismissAlarmScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
		}
    }
}
