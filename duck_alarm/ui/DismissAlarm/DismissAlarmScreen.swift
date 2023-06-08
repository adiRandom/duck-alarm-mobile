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
