//
//  PreferencesRepository.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 10.06.2023.
//

import Foundation

class PreferencesRepository {
	private let userPrefs = UserDefaults.standard
	private static let STEPS_TO_DISMISS = "STEPS_TO_DISMISS"
	// Seconds
	private static let MUTE_FOR_TIME = "MUTE_FOR_TIME"
	
	private static var instance:PreferencesRepository? = nil
	
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
	
	private init() {
		initPropertesToDefaults()
	}
	
	private func initPropertesToDefaults(){
		if userPrefs.object(forKey: PreferencesRepository.STEPS_TO_DISMISS) == nil{
			stepsToDismiss = 30
		}
		
		if userPrefs.object(forKey: PreferencesRepository.MUTE_FOR_TIME) == nil{
			muteForTime = 30
		}
	}
	
	static func getInstance()->PreferencesRepository{
		if instance == nil{
			instance = PreferencesRepository()
		}
		
		return instance!
	}
}
