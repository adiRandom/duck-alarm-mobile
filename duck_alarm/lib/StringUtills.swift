//
//  StringUtills.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 30.05.2023.
//

enum StringUtils {
	private static func getAsTwoDigit(value: Int)->String {
		if value < 10 {
			return "0\(value)"
		}

		return String(value)
	}

	static func formatHourAndMin(hour: Int, min: Int)->String {
		return "\(getAsTwoDigit(value: hour)):\(getAsTwoDigit(value: min))"
	}

	static func getRepeatDaysAsString(repeatDays: [Int])->String {
		if repeatDays.count == 7 {
			return "Every Day"
		} else if repeatDays.contains(5) && repeatDays.contains(6) {
			return "Weekend"
		} else if repeatDays.count == 5 && repeatDays.allSatisfy({ el in el != 5 && el != 6 }) {
			return "Week Days"
		} else if repeatDays.count == 0 {
			return "No Repeat"
		} else {
			return String(repeatDays.reduce("") { acc, curr in acc + curr.getWeekDay() + ", " }.dropLast(2))
		}
	}
}
