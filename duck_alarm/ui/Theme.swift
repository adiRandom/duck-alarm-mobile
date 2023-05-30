//
//  Theme.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 23.05.2023.
//

import SwiftUI

struct Theme{
	static let PRIMARY_COLOR = Color(hex: 0xE3BC2D)
	static let PRIMARY_COLOR_DARK = Color(hex: 0xFCD74E)
	static let DISABLED_LIGHT = Color(hex:0x333333)
	static let DISABLED_DARK = Color(hex:0xE3E3E3)
}


extension Color {
	init(hex: Int, opacity: Double = 1.0) {
		let red = Double((hex & 0xff0000) >> 16) / 255.0
		let green = Double((hex & 0xff00) >> 8) / 255.0
		let blue = Double((hex & 0xff) >> 0) / 255.0
		self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
	}
}
