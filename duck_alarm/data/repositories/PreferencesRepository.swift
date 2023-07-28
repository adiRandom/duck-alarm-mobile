//
//  PreferencesRepository.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 10.06.2023.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class PreferencesRepository {
	private let userPrefs = UserDefaults.standard
	private static let STEPS_TO_DISMISS = "STEPS_TO_DISMISS"
	// Seconds
	private static let MUTE_FOR_TIME = "MUTE_FOR_TIME"
	
	private static var instance: PreferencesRepository?
	
	private let firestore = Firestore.firestore()
	private static let METADATA_COLLECTION = "metadata"

	var stepsToDismiss: Int {
		get {
			return userPrefs.integer(forKey: PreferencesRepository.STEPS_TO_DISMISS)
		}
		
		set {
			userPrefs.setValue(newValue, forKey: PreferencesRepository.STEPS_TO_DISMISS)
		}
	}
	
	var muteForTime: Int {
		get {
			return userPrefs.integer(forKey: PreferencesRepository.MUTE_FOR_TIME)
		}
		
		set {
			userPrefs.setValue(newValue, forKey: PreferencesRepository.MUTE_FOR_TIME)
		}
	}
		
	func setIsAlarmEnabled(isEnabled: Bool) { firestore.collection(PreferencesRepository.METADATA_COLLECTION).document(PreferencesRepository.METADATA_COLLECTION).updateData(["canRing": isEnabled])
	}
	
	func getIsAlarmEnabled() async -> Bool {
		return await withCheckedContinuation { continuation in
			firestore.collection(PreferencesRepository.METADATA_COLLECTION)
				.document(PreferencesRepository.METADATA_COLLECTION)
				.getDocument { document, _ in
					do {
						if let doc = document {
							continuation.resume(returning:try doc.data(as: MetadataModel.self).canRing)
						}
					} catch {
						continuation.resume(returning: false)
					}
				}
		}
	}
	
	private init() {
		initPropertesToDefaults()
	}
	
	private func initPropertesToDefaults() {
		if userPrefs.object(forKey: PreferencesRepository.STEPS_TO_DISMISS) == nil {
			stepsToDismiss = 30
		}
		
		if userPrefs.object(forKey: PreferencesRepository.MUTE_FOR_TIME) == nil {
			muteForTime = 30
		}
	}
	
	static func getInstance() -> PreferencesRepository {
		if instance == nil {
			instance = PreferencesRepository()
		}
		
		return instance!
	}
}
