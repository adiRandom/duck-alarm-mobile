//
//  ContetnViewViewModel.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 30.05.2023.
//

import SwiftUI

class ContentViewViewModel:ObservableObject{
	init(){
		
	}
	
	@Published
	var alarms: [AlarmModel] = []
	
	@Published
	var isBottomSheetPresented = false
	
	@Published
	var selectedAlarmModel:AlarmModel? = nil
	
	func addAlarm(){
		isBottomSheetPresented = true
	}
}
