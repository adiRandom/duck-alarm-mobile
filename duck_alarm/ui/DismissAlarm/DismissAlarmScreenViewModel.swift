//
//  DismissAlarmScreenViewModel.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 09.06.2023.
//

import CoreMotion
import Foundation

class DismissAlarmScreenViewModel: ObservableObject {
	@Published
	var time: String = ""
	
	@Published
	var isPm: Bool = false
	
	@Published
	var steps: Int = 0
	
	let stepGoal: Int
	
	private let preferencesRepository = PreferencesRepository.getInstance()
	private let pedometer = CMPedometer()
	
	private func updateTimer() {
		let time = Date()
		let hour = time.get12hHour()
		let minute = time.getMinute()
		
		isPm = time.isPm()
		self.time = StringUtils.formatHourAndMin(hour: hour, min: minute)
	}
	
	private var timer: Timer = .init()
	private var pedometerTimer = Timer()
	
	init() {
		let time = Date()
		let hour = time.get12hHour()
		let minute = time.getMinute()
		
		isPm = time.isPm()
		self.time = StringUtils.formatHourAndMin(hour: hour, min: minute)
		stepGoal = preferencesRepository.stepsToDismiss
		
	}
	
	func startTimer() {
		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
			self?.updateTimer()
		}
		pedometerTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
			self?.pedometer.queryPedometerData(from: Date() - 5, to: Date()) { data, _ in
				DispatchQueue.main.sync {
					self?.steps += data?.numberOfSteps.intValue ?? 0
				}
			}
		}
	}
	
	deinit {
		timer.invalidate()
		pedometerTimer.invalidate()
	}
}
