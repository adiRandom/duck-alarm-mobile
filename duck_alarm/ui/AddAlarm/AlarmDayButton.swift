//
//  AlarmDayButton.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 01.06.2023.
//

import SwiftUI

struct AlarmDayButton: View {
	let day: Int
	@State var isToggled = false
	let onToggle: (Int, Bool)->Void
	@IsDarkMode var isDarkMode
	@PrimaryColor var primaryColor

	private func getBackgroundColor()->Color {
		return isToggled == true ? primaryColor : Color.clear
	}

	private func getBorderColor()->Color {
		return isToggled == true ? Color.clear : primaryColor
	}

	private func getTextColor()->Color {
		if isToggled {
			return isDarkMode == true ? Color.black : Color.white
		} else {
			return primaryColor
		}
	}

	func handleToggle() {
		isToggled = !isToggled
		onToggle(day, isToggled)
	}

	var body: some View {
		Button(action: {handleToggle()}) {
			Text(day.getWeekDay())
				.frame(width: 32, height: 32)
				.foregroundColor(getTextColor())
				.background(getBackgroundColor())
				.cornerRadius(32)
				.border(width: 2,
				        color: getBorderColor(),
				        cornerRadius: 32)
		}
	}
}

struct AlarmDayButton_Previews: PreviewProvider {
	static var previews: some View {
		AlarmDayButton(day: 1) { _, _ in }
	}
}
