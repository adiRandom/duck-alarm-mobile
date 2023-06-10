//
//  DismissAlarmScreen.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 07.06.2023.
//

import SwiftUI

struct DismissAlarmScreen: View {
	@StateObject var viewModel = DismissAlarmScreenViewModel()
	var body: some View {
		VStack {
			ThemedText("Time to Move!", fontSize: 36, fontWeight: .light, textColor: ThemeColor(color: .white))
				.padding([.top], 64)
			HStack(alignment: .firstTextBaseline) {
				ThemedText(viewModel.time, fontSize: 60, fontWeight: .bold, textColor: ThemeColor.White)
				ThemedText(viewModel.isPm ? "PM" : "AM", fontSize: 28, fontWeight: .semibold, textColor: .Primary)
			}.padding([.top], 100)

			ThemedText("Steps Taken", fontSize: 36, fontWeight: .semibold, textColor: .White)
				.padding([.top], 64)
			HStack(spacing: 0) {
				ThemedText("\(viewModel.steps) /",
				           fontSize: 36, textColor: .White)
				ThemedText(" \(viewModel.stepGoal)",
				           fontSize: 36, textColor: .Primary)
			}
			Spacer()
			// TODO: Make me pretty
			Button("Silence") {}
				.padding([.leading, .trailing], 32)
				.background(ThemeColor.Primary.resolveColor(isDarkTheme: false))
				.cornerRadius(16)
				.buttonStyle(.bordered)

			Spacer()

		}.frame(maxWidth: .infinity)
			.background(LinearGradient(colors: [Color(hex: 0x43cea2), Color(hex: 0x185a9d)], startPoint: .topLeading, endPoint: .bottomTrailing))
			.onAppear {
				viewModel.startTimer()
			}
	}
}

struct DismissAlarmScreen_Previews: PreviewProvider {
	static var previews: some View {
		DismissAlarmScreen()
	}
}
