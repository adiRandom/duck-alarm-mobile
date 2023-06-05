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
		
		self.fetchAlarms()
	}
	
	@Published
	var isBottomSheetPresented = false
	
	@Published
	var selectedAlarmModel: AlarmModel? = nil
	
	@Published
	var alarms: [AlarmModel] = []
	
	let alarmRepository: AlarmRepository
	
	func addAlarm() {
		isBottomSheetPresented = true
	}
	
	func saveAlarm(selectedTime: Date, repeatDays: [Int]) {
		var hour = Calendar.current.component(.hour, from: selectedTime)
		var isPm = false

		if hour > 12 {
			isPm = true
			hour -= 12
		} else if hour == 12 {
			isPm = true
		}

		let minute = Calendar.current.component(.minute, from: selectedTime)

		var model = AlarmModel(hour: hour, min: minute, isPm: isPm, repeatingDays: repeatDays, active: true)
		
		if let selectedAlarmModel {
			model.id = selectedAlarmModel.id
			updateAlarm(alarmModel: model)
			fetchAlarms()
		} else {
			alarmRepository.insertAlarm(alarm: model)
		}
	}
	
	private func updateAlarm(alarmModel: AlarmModel) {
		alarmRepository.updateAlarm(alarm: alarmModel)
	}
	
	func onIsActiveChange(alarm:AlarmModel, isActive: Bool){
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
	
	private func fetchAlarms(){
		let newAlarms = alarmRepository.getAlarmList()
		self.alarms = newAlarms
	}
}
