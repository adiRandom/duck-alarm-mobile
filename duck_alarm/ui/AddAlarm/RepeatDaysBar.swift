//
//  RepeatDaysBar.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 03.06.2023.
//

import SwiftUI

struct RepeatDaysBar: View {
	@Binding var repeatDays: [Int]
	
	var body: some View {
		HStack {
			ForEach(0 ..< 7) { dayIndex in
				AlarmDayButton(day: dayIndex, isToggled: repeatDays.contains(dayIndex)) { day, value in
					if value {
						repeatDays.append(day)
						repeatDays.sort()
					} else {
						repeatDays = repeatDays.filter { el in el != day }
					}
				}
			}
		}
	}
}

struct RepeatDaysBar_Previews: PreviewProvider {
	
	struct PreviewView: View{
		@State var repeatDays: [Int] = []

		var body: some View{
			VStack {
				RepeatDaysBar(repeatDays: $repeatDays)
				ThemedText(StringUtils.getRepeatDaysAsString(repeatDays: repeatDays))
			}
		}
	}
	
	static var previews: some View {
		PreviewView()
	}
}
