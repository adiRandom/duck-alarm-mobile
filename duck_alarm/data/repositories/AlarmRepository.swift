//
//  AlarmRepository.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 03.06.2023.
//

import CoreData
import SwiftUI

class AlarmRepository: ObservableObject {
	private let db = Database.shared

	func saveAlarm(alarm: AlarmModel) {
		db.container.viewContext.insert(AlarmEntity(model: alarm, context: db.container.viewContext))
		do {
			try db.container.viewContext.save()
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
	}
}
