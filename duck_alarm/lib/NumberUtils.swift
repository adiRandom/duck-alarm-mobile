//
//  NumberUtils.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 01.06.2023.
//

extension Int {
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

