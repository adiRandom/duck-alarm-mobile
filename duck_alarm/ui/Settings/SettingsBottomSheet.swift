//
//  SettingsBottomSheet.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 11.06.2023.
//

import SwiftUI

struct SettingsBottomSheet: View {
	@State var stepsToDismiss = "30"
	@State var timeForSilence = "30"
	@IsDarkMode var isDarkMode
	@Binding var isPresented: Bool

	let onSave: (_ steps: Int, _ silence: Int) -> Void

	func handleSave() {
		onSave(Int(stepsToDismiss) ?? 0, Int(timeForSilence) ?? 0)
		dismiss()
	}

	func dismiss() {
		isPresented = false
	}

	var body: some View {
		NavigationStack {
			List {
				HStack {
					ThemedText("Steps to Dismiss:", textColor: .Label)
					TextField("", text: $stepsToDismiss)
						.textFieldStyle(.plain)
						.keyboardType(.numberPad)
				}
				.padding([.top, .bottom], 8)
				.padding([.leading, .trailing], 16)
				HStack {
					ThemedText("Time for Silence (s):", textColor: .Label)
						.frame(minWidth: 160)
					TextField("", text: $timeForSilence)
						.textFieldStyle(.plain)
						.keyboardType(.numberPad)
				}
				.padding([.top, .bottom], 8)
				.padding([.leading, .trailing], 16)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button("Save") {
						handleSave()
					}.foregroundColor(
						ThemeColor.Primary.resolveColor(
							isDarkTheme: isDarkMode
						)
					)
				}
				ToolbarItem(placement: .navigationBarLeading) {
					Button("Cancel") {
						dismiss()
					}.foregroundColor(
						ThemeColor.Primary.resolveColor(
							isDarkTheme: isDarkMode
						)
					)
				}
			}
		}
	}
}

struct SettingsBottomSheet_Previews: PreviewProvider {
	static var previews: some View {
		SettingsBottomSheet(isPresented: .constant(true), onSave: { _, _ in })
	}
}
