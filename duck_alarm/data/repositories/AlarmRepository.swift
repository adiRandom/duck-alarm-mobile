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

	func insertAlarm(alarm: AlarmModel) {
		db.container.viewContext.insert(AlarmEntity(model: alarm, context: db.container.viewContext))
		do {
			try db.container.viewContext.save()
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
	}

	func getAlarmList() -> [AlarmModel] {
		let fetchRequest = AlarmEntity.fetchRequest()
		fetchRequest.sortDescriptors = [
			NSSortDescriptor(SortDescriptor<AlarmEntity>(\.isPm)),
			NSSortDescriptor(SortDescriptor<AlarmEntity>(\.hour)),
			NSSortDescriptor(SortDescriptor<AlarmEntity>(\.minute)),
		]
		do {
			let entities = try db.container.viewContext.fetch(fetchRequest)
			return entities.map { $0.toModel() }
		} catch {
			return []
		}
	}

	private func getAlarmEntity(id: Int) -> AlarmEntity? {
		let fetchRequest = AlarmEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %lld", id)
		do {
			let fetchResult = try db.container.viewContext.fetch(fetchRequest)
			return fetchResult.first
		} catch {
			return nil
		}
	}

	func updateAlarm(alarm: AlarmModel) {
		guard let alarmEntity = getAlarmEntity(id: alarm.id) else {
			return
		}

		alarmEntity.updateFromModel(model: alarm)
		do {
			try db.container.viewContext.save()
		} catch {
			return
		}
	}
}
