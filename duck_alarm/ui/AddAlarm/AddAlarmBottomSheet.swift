//
//  AddAlarmBottomSheet.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 01.06.2023.
//

import SwiftUI

struct AddAlarmBottomSheet: View {
	@State var selectedTime = Date()

	var body: some View {
		VStack (alignment: .center){
			ThemedText("Add Alarm",isDisabled: false,fontSize: 24.0)
			DatePicker(selection: $selectedTime, displayedComponents: .hourAndMinute){}
				.datePickerStyle(.wheel)
				.labelsHidden()
		}
	}
}

struct AddAlarmBottomSheet_Previews: PreviewProvider {
	static var previews: some View {
		AddAlarmBottomSheet()
	}
}
