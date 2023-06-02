//
//  AddAlarmBottomSheet.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 01.06.2023.
//

import SwiftUI

struct AddAlarmBottomSheet: View {
	let isEditable: Bool

	@State var selectedTime: Date = .init()
	@State var repeatDays: [Int] = []

	init(alarmModel: AlarmModel?) {
		if let alarmModel {
			isEditable = true
			repeatDays = alarmModel.repeatingDays
			selectedTime = TimeUtils.createDate(hour: alarmModel.hour, minute: alarmModel.min, isPm: alarmModel.isPm)
		} else {
			isEditable = false
			selectedTime = Date()
			repeatDays = []
		}
	}

	var body: some View {
		VStack(alignment: .center) {
			ThemedText("Add Alarm", isDisabled: false, fontSize: 24.0)
				.padding([.bottom], 64)
			DatePicker(selection: $selectedTime, displayedComponents: .hourAndMinute) {}
				.datePickerStyle(.wheel)
				.labelsHidden()
			HStack {
				ForEach(0 ..< 7) { dayIndex in
					AlarmDayButton(day: dayIndex)
				}
			}.padding([.bottom], 20)
			VStack {
				Button(action: {}) { Text("Save")
					.frame(maxWidth: .infinity)
				}
				if isEditable {
					Divider()
					Button(role: .destructive, action: {}, label: { Text("Delete")
							.frame(maxWidth: .infinity)
					})
				}
			}
			.padding([.top, .bottom], 8)
			.background(Color(UIColor.secondarySystemFill))
			.cornerRadius(12)
		}.padding([.trailing, .leading], 24)
	}
}

struct AddAlarmBottomSheet_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			AddAlarmBottomSheet(alarmModel: nil)
				.previewDisplayName("Add")
			// TODO: Debug this
			AddAlarmBottomSheet(alarmModel: AlarmModel(
				hour: 4, min: 20, isPm: true, repeatingDays: [1, 3], active: true
			))
			.previewDisplayName("Edit")
		}
	}
}
