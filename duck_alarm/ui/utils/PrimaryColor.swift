//
//  PrimaryColor.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 01.06.2023.
//

import SwiftUI

@propertyWrapper
struct PrimaryColor:DynamicProperty{
	@IsDarkMode var isDarkMode
	
	var wrappedValue: Color{
		get{
			return isDarkMode == true ? Theme.PRIMARY_COLOR_DARK : Theme.PRIMARY_COLOR
		}
	}
}
