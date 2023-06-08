//
//  DismissAlarmScreenViewModel.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 09.06.2023.
//

import Foundation

class DismissAlarmScreenViewModel: ObservableObject {
	@Published
	var time: String = ""
	
	@Published
	var isPm: Bool = false
	
	private func updateTimer() {
		let time = Date()
		let hour = time.get12hHour()
		let minute = time.getMinute()
		
		isPm = time.isPm()
		self.time = StringUtils.formatHourAndMin(hour: hour, min: minute)
	}
	
	private var timer: Timer = Timer()
	
	init() {
		let time = Date()
		let hour = time.get12hHour()
		let minute = time.getMinute()
		
		isPm = time.isPm()
		self.time = StringUtils.formatHourAndMin(hour: hour, min: minute)
	}
	
	func startTimer(){
		self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
			self?.updateTimer()
		}
	}
	
	deinit {
		timer.invalidate()
	}
}
