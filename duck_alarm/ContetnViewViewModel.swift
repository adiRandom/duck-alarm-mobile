//
//  ContetnViewViewModel.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 30.05.2023.
//

import SwiftUI

class ContentViewViewModel: ObservableObject {
	init(alarmRepository: AlarmRepository) {
		self.alarmRepository = alarmRepository
		
		fetchAlarms()
	}
	
	@Published
	var isBottomSheetPresented = false
	
	@Published
	var isSettingsBottomSheetPresented = false
	
	@Published
	var currentStepsGoal = 0
	
	@Published
	var currentTimeForSilece = 0
	
	@Published
	var isAlarmEnabled = false
	
	@Published
	var selectedAlarmModel: AlarmModel? = nil
	
	@Published
	var alarms: [AlarmModel] = []
	
	let alarmRepository: AlarmRepository
	let preferencesRepository = PreferencesRepository.getInstance()
	
	func addAlarm() {
		isBottomSheetPresented = true
	}
	
	func saveAlarm(selectedTime: Date, repeatDays: [Int]) {
		Task {
			let hour = selectedTime.get12hHour()
			let isPm = selectedTime.isPm()
			let minute = selectedTime.getMinute()
			
			var model = AlarmModel(hour: hour, min: minute, isPm: isPm, repeatingDays: repeatDays, active: true)
			
			if let selectedAlarmModel {
				model.id = selectedAlarmModel.id
				updateAlarm(alarmModel: model)
			} else {
				alarmRepository.insertAlarm(alarm: model)
			}
			
			fetchAlarms()
		}
	}
	
	private func updateAlarm(alarmModel: AlarmModel) {
		alarmRepository.updateAlarm(alarm: alarmModel)
	}
	
	func onIsActiveChange(alarm: AlarmModel, isActive: Bool) {
		var newAlarm = AlarmModel(alarm: alarm)
		newAlarm.isActive = isActive
		updateAlarm(alarmModel: newAlarm)
	}
	
	func editAlarm(alarm: AlarmModel) {
		selectedAlarmModel = alarm
		isBottomSheetPresented = true
	}
	
	func onBottomSheetClose() {
		selectedAlarmModel = nil
	}
	
	private func fetchAlarms() {
		Task {
			let newAlarms = await alarmRepository.getAlarmList()
			await MainActor.run {
				alarms = newAlarms
			}
		}
	}
	
	func showSettings() {
		Task {
			await showSettings(isAlarmEnabled: await preferencesRepository.getIsAlarmEnabled())
		}
	}
	
	@MainActor
	private func showSettings(isAlarmEnabled: Bool) {
		currentStepsGoal = preferencesRepository.stepsToDismiss
		currentTimeForSilece = preferencesRepository.muteForTime
		self.isAlarmEnabled = isAlarmEnabled
		isSettingsBottomSheetPresented = true
	}
	
	func onSave(stepGoal: Int, silenceTime: Int, isAlarmEnabled: Bool) {
		preferencesRepository.stepsToDismiss = stepGoal
		preferencesRepository.muteForTime = silenceTime
		preferencesRepository.setIsAlarmEnabled(isEnabled: isAlarmEnabled)
	}
	
	func onDeleteSelected() {
		if let alarmModel = selectedAlarmModel {
			alarmRepository.deleteAlarm(alarmId: alarmModel.id)
			fetchAlarms()
		}
	}
}
