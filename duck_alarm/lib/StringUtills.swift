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
		} else {
			return String(repeatDays.reduce("") { acc, curr in acc + curr.getWeekDay() + ", " }.dropLast(2))
		}
	}
}

private extension Int {
	func getWeekDay()->String {
		switch self {
		case 0:
			return "Mo"
		case 1:
			return "Tu"
		case 2:
			return "We"
		case 3:
			return "Th"
		case 4:
			return "Fr"
		case 5:
			return "Sa"
		case 6:
			return "Su"
		default:
			return ""
		}
	}
}
