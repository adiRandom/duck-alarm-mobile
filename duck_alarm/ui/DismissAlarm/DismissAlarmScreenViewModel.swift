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
	private let alarmRepository = AlarmRepository()
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
	
	@Published
	var isSleepButtonDisabled: Bool = false
	
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
					if let data {
						self?.onStep(data: data)
					}
				}
			}
		}
	}
	
	deinit {
		stopPedometer()
	}
	
	private func stopPedometer() {
		timer.invalidate()
		pedometerTimer.invalidate()
	}
	
	private func onStep(data: CMPedometerData) {
		steps += data.numberOfSteps.intValue
		
		if steps >= preferencesRepository.stepsToDismiss {
			onDismiss()
		}
	}
	
	func onSilence() {
		alarmRepository.silenceAlarm(){ [weak self] isSilenced in
			self?.isSleepButtonDisabled = isSilenced
		}
	}
	
	private func onDismiss() {
		Task{
			await alarmRepository.dismissAlarm()
			await MainActor.run{
				exit(0)
			}
		}
	}
}
