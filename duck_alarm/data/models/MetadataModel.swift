//
//  MetadataModel.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 28.07.2023.
//

import Foundation

struct MetadataModel: Decodable {
	let fcmToken: String
	let canRing: Bool
	let shouldRing: Bool
}
