//
//  duck_alarmApp.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 14.05.2023.
//

import SwiftUI
import AVKit

@main
struct duck_alarmApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
		}
    }
}
