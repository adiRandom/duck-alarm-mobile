//
//  NavController.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 27.07.2023.
//

import Foundation

class NavController: ObservableObject{
	@Published var startingRoute = HOME
	
	static let HOME = "home"
	static let ALARM = "alarm"
}
