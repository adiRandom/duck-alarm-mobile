//
//  AlarmVIew.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 30.05.2023.
//

import SwiftUI

struct AlarmVIew: View {
	@ObservedObject var alarm: AlarmModel

	private func formatHour() -> String {
		return "\(alarm.hour):\(alarm.min)"
	}

	var body: some View {
		VStack {
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
			// TODO: Add repeat time
			ThemedText("")
		}
		.padding(EdgeInsets(top: 12.0, leading: 24.0, bottom: 12.0, trailing: 24.0))
	}
}

struct AlarmVIew_Previews: PreviewProvider {
	static var previews: some View {
		@ObservedObject var alarm = AlarmModel(hour: 9, min: 25, isPm: false, repeatingDays: [], active: true)
		AlarmVIew(alarm: alarm)
	}
}
