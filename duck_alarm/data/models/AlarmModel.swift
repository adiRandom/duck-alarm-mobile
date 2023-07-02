//
//  AlarmModel.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 23.05.2023.
//

import Foundation
import SwiftUI

public struct AlarmModel: Hashable, Identifiable, Equatable, Codable {
	public static func == (lhs: AlarmModel, rhs: AlarmModel) -> Bool {
		lhs.id == rhs.id && lhs.hour == rhs.hour && lhs.min == rhs.min && lhs.isPm == rhs.isPm
	}

	public var id: Int
	let hour: Int
	let min: Int
	let isPm: Bool
	var repeatingDays: [Int]
	var isActive: Bool

	init(
		id: Int = Int.random(in: 0 ..< Int.max),
		hour: Int,
		min: Int,
		isPm: Bool,
		repeatingDays: [Int],
		active: Bool
	) {
		self.id = id
		self.hour = hour
		self.min = min
		self.isPm = isPm
		self.repeatingDays = repeatingDays
		self.isActive = active
	}

	init() {
		self.id = Int.random(in: 0 ..< Int.max)
		self.hour = 12
		self.min = 00
		self.isPm = true
		self.repeatingDays = []
		self.isActive = true
	}

	init(alarm: AlarmModel) {
		self.id = alarm.id
		self.hour = alarm.hour
		self.min = alarm.min
		self.isPm = alarm.isPm
		self.repeatingDays = alarm.repeatingDays
		self.isActive = alarm.isActive
	}

	enum CodingKeys: String, CodingKey {
		case id
		case hour
		case min
		case isPm
		case repeatingDays
		case isActive
	}
}
