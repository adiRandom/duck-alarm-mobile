//
//  IsDarkTheme.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 23.05.2023.
//

import SwiftUI

@propertyWrapper
struct IsDarkMode:DynamicProperty{
	@Environment(\.colorScheme) var colorScheme
	
	var wrappedValue: Bool{
		get{
			colorScheme == .dark
		}
	}
}
