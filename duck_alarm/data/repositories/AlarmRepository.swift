//
//  AlarmRepository.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 03.06.2023.
//

import CoreData
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class AlarmRepository: ObservableObject {
	private let db = Database.shared
	private let firestore = Firestore.firestore()

	private static let COLLECTION = "alarms"
	private static let METADATA_COLLECTION = "metadata"

	func insertAlarm(alarm: AlarmModel, withRemote: Bool = true) {
		db.container.viewContext.insert(AlarmEntity(model: alarm, context: db.container.viewContext))
		do {
			try db.container.viewContext.save()
			if withRemote {
				try insertIntoFirestore(alarm: alarm)
			}
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
	}

	func getAlarmList() async -> [AlarmModel] {
		let fetchRequest = AlarmEntity.fetchRequest()
		fetchRequest.sortDescriptors = [
			NSSortDescriptor(SortDescriptor<AlarmEntity>(\.isPm)),
			NSSortDescriptor(SortDescriptor<AlarmEntity>(\.hour)),
			NSSortDescriptor(SortDescriptor<AlarmEntity>(\.minute)),
		]
		do {
			let entities = try db.container.viewContext.fetch(fetchRequest)
			let models = entities.map { $0.toModel() }

			if models.isEmpty {
				let remoteModels = await getAlarmsFromFirestore()
				remoteModels.forEach { model in
					insertAlarm(alarm: model, withRemote: false)
				}

				return remoteModels
			} else {
				return models
			}
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
			try insertIntoFirestore(alarm: alarm)
		} catch {
			return
		}
	}

	private func insertIntoFirestore(alarm: AlarmModel) throws {
		try firestore.collection(AlarmRepository.COLLECTION).document(String(alarm.id)).setData(from: alarm)
	}

	private func getAlarmsFromFirestore() async -> [AlarmModel] {
		await withCheckedContinuation { continuation in
			firestore.collection(AlarmRepository.COLLECTION).getDocuments { querySnapshot, _ in
				do {
					var result: [AlarmModel] = []

					for document in querySnapshot!.documents {
						let model = try document.data(as: AlarmModel.self)
						result.append(model)
					}

					continuation.resume(returning: result)
				} catch {
					continuation.resume(returning: [])
				}
			}
		}
	}

	func dismissAlarm() {
		firestore.collection(AlarmRepository.METADATA_COLLECTION).document(AlarmRepository.METADATA_COLLECTION).setData(["shouldRing": false])
	}

	func silenceAlarm() {
		Task {
			async let _: Void = try firestore.collection(AlarmRepository.METADATA_COLLECTION).document(AlarmRepository.METADATA_COLLECTION).setData(["shouldRing": false])

			let sleepDuration = PreferencesRepository.getInstance().muteForTime
			try await Task.sleep(for: .seconds(sleepDuration))

			async let _: Void = try firestore.collection(AlarmRepository.METADATA_COLLECTION).document(AlarmRepository.METADATA_COLLECTION).setData(["shouldRing": true])
		}
	}
}
