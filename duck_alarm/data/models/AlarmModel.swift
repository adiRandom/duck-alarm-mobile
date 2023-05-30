//
//  AlarmModel.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 23.05.2023.
//

import Foundation

class AlarmModel: ObservableObject, Identifiable {
	let id: Int
	let hour: Int
	let min: Int
	let isPm: Bool
	let repeatingDays: [Int]
	@Published
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
}
