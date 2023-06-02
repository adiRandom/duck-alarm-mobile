//
//  AddAlarmBottomSheet.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 01.06.2023.
//

import SwiftUI

struct AddAlarmBottomSheet: View {
	let isEditable: Bool
	let onSaveAlarm: (_ selectedTime: Date, _ repeatDays: [Int])->Void

	@State var selectedTime: Date
	@State var repeatDays: [Int]

	init(
		alarmModel: AlarmModel?,
		onSaveAlarm: @escaping (_ selectedTime: Date, _ repeatDays: [Int])->Void
	) {
		if let alarmModel {
			isEditable = true
			_repeatDays = State(initialValue: alarmModel.repeatingDays)
			_selectedTime = State(initialValue: TimeUtils.createDate(hour: alarmModel.hour, minute: alarmModel.min, isPm: alarmModel.isPm))
		} else {
			isEditable = false
			_selectedTime = State(initialValue: Date())
			_repeatDays = State(initialValue: [])
		}

		self.onSaveAlarm = onSaveAlarm
	}

	var body: some View {
		VStack(alignment: .center) {
			ThemedText("Add Alarm", isDisabled: false, fontSize: 24.0)
				.padding([.bottom], 32)
				.padding([.top], 48)
			DatePicker(selection: $selectedTime, displayedComponents: .hourAndMinute) {}
				.datePickerStyle(.wheel)
				.labelsHidden()
			HStack {
				ForEach(0 ..< 7) { dayIndex in
					AlarmDayButton(day: dayIndex, isToggled: repeatDays.contains(dayIndex))
				}
			}.padding([.bottom], 20)
			VStack(spacing: 8) {
				Button(action: { onSaveAlarm(selectedTime, repeatDays) }) { Text("Save")
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
			AddAlarmBottomSheet(alarmModel: nil, onSaveAlarm: { _, _ in

			}).previewDisplayName("Add")
			AddAlarmBottomSheet(alarmModel: AlarmModel(
				hour: 4, min: 20, isPm: true, repeatingDays: [1, 3], active: true
			), onSaveAlarm: { _ in

			})
			.previewDisplayName("Edit")
		}
	}
}
