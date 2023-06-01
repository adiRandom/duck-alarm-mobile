//
//  AlarmVIew.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 30.05.2023.
//

import SwiftUI

struct AlarmView: View {
	@ObservedObject var alarm: AlarmModel

	private func formatHour() -> String {
		return "\(alarm.hour):\(alarm.min)"
	}

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				HStack(alignment: .lastTextBaseline) {
					ThemedText(
						StringUtils.formatHourAndMin(hour: alarm.hour, min: alarm.min),
						fontSize: 36.0,
						fontWeight: .semibold
					)
					ThemedText(alarm.isPm == true ?"PM" : "AM",
					           fontSize: ThemedText.DEFAULT_SIZE,
					           isPrimaryColor: true)
				}
				Spacer()
				Toggle("", isOn: $alarm.isActive)
			}
			ThemedText(StringUtils.getRepeatDaysAsString(repeatDays: alarm.repeatingDays), isDisabled: true)
		}
		.padding(EdgeInsets(top: 12.0, leading: 24.0, bottom: 12.0, trailing: 24.0))
	}
}

struct AlarmVIew_Previews: PreviewProvider {
	static var previews: some View {
		@ObservedObject var alarm = AlarmModel(hour: 9, min: 25, isPm: false, repeatingDays: [0, 3, 5], active: true)
		@ObservedObject var alarmWeekend = AlarmModel(hour: 12, min: 25, isPm: false, repeatingDays: [5, 6], active: false)
		@ObservedObject var alarmWeekdays = AlarmModel(hour: 9, min: 00, isPm: true, repeatingDays: [0, 1, 2, 3, 4], active: false)
		@ObservedObject var alarmAll = AlarmModel(hour: 11, min: 02, isPm: true, repeatingDays: [0, 1, 2, 3, 4, 5, 6], active: true)

		Group {
			AlarmView(alarm: alarm).previewDisplayName("Individual Days")
			AlarmView(alarm: alarmWeekend).previewDisplayName("Weekend")
			AlarmView(alarm: alarmWeekdays).previewDisplayName("Week days")
			AlarmView(alarm: alarmAll).previewDisplayName("All")
		}
	}
}
