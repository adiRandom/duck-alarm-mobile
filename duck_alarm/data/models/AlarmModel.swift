//
//  AlarmModel.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 23.05.2023.
//

import Foundation


struct AlarmModel{
	let id: Int
	let hour: Int
	let min: Int
	let repeatingDays: [Int]
	let active: Bool
}
