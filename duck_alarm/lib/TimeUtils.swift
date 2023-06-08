//
//  TimeUtils.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 01.06.2023.
//

import Foundation

struct TimeUtils{
	static func createDate(hour: Int, minute: Int, isPm: Bool) -> Date {
		var calendar = Calendar.current
		calendar.timeZone = TimeZone.current
		
		var dateComponents = DateComponents()
		dateComponents.hour = hour == 12 ? (isPm ? 12 : 0) : (isPm ? hour + 12 : hour)
		dateComponents.minute = minute
		
		return calendar.date(from: dateComponents) ?? Date()
	}
}


extension Date{
	func get12hHour()->Int{
		let hour = Calendar.current.component(.hour, from: self)
		
		return hour > 12 ? hour - 12 : hour
	}
	
	func isPm()->Bool{
		let hour = Calendar.current.component(.hour, from: self)
		return hour >= 12
	}
	
	func getMinute()->Int{
		return Calendar.current.component(.minute, from: self)
	}
}
