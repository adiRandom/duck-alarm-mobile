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
		calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
		
		var dateComponents = DateComponents()
		dateComponents.hour = isPm ? hour + 12 : hour
		dateComponents.minute = minute
		
		return calendar.date(from: dateComponents) ?? Date()
	}
}
