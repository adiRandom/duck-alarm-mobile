//
//  ThemeColor.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 09.06.2023.
//

import Foundation
import SwiftUI

struct ThemeColor {
	let lightThemeColor: Color
	let darkThemeColor: Color

	init(color: Color) {
		lightThemeColor = color
		darkThemeColor = color
	}
	
	init(lightTheme: Color, darkTheme:Color){
		lightThemeColor = lightTheme
		darkThemeColor = darkTheme
	}

	func resolveColor(isDarkTheme: Bool) -> Color {
		if isDarkTheme {
			return darkThemeColor
		} else {
			return lightThemeColor
		}
	}
}


extension ThemeColor{
	static let Primary = ThemeColor(lightTheme: Theme.PRIMARY_COLOR, darkTheme: Theme.PRIMARY_COLOR_DARK)
	static let Disabled = ThemeColor(lightTheme: Theme.DISABLED_LIGHT, darkTheme: Theme.DISABLED_DARK)
	static let White = ThemeColor(color: .white)
	static let Label = ThemeColor(color: Theme.LABEL)
}

