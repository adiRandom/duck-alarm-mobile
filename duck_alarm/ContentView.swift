//
//  ContentView.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 14.05.2023.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = ContentViewViewModel(
		alarmRepository: AlarmRepository()
	)

	var body: some View {
		NavigationStack {
			VStack {
				if viewModel.alarms.isEmpty {
					ThemedText("No alarms set yet", fontStyle: .title2, isDisabled: true)
				} else {
					ForEach(viewModel.alarms, id: \.self) { alarm in
						AlarmView(alarm: alarm, onIsActiveChange: {
							isActive in viewModel.onIsActiveChange(alarm: alarm, isActive: isActive)
						}, onOpenEdit: { alarm in viewModel.editAlarm(alarm: alarm) })
					}
					Spacer()
				}
			}
			.navigationTitle("Alarms")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: viewModel.showSettings) {
						ThemedLabel(text: "Settings", systemIcon: "gear")
					}
				}

				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: viewModel.addAlarm) {
						ThemedLabel(text: "Add Item", systemIcon: "plus")
					}
				}
			}

			.sheet(isPresented: $viewModel.isBottomSheetPresented) {
				AddAlarmBottomSheet(
					alarmModel: viewModel.selectedAlarmModel,
					isBottomSheetPresented: $viewModel.isBottomSheetPresented
				) { selectedTime, repeatDays in
					viewModel.saveAlarm(selectedTime: selectedTime, repeatDays: repeatDays)
				}
				.presentationDragIndicator(.visible)
				.presentationDetents([.fraction(0.6)])
			}

			.sheet(isPresented: $viewModel.isSettingsBottomSheetPresented) {
				SettingsBottomSheet(
					stepsToDismiss: String(viewModel.currentStepsGoal),
					timeForSilence: String(viewModel.currentTimeForSilece),
					isPresented: $viewModel.isSettingsBottomSheetPresented
				) { stepGoal, silenceTime in
					viewModel.onSave(stepGoal: stepGoal, silenceTime: silenceTime)
				}
				.presentationDetents([.medium])
			}
			.onChange(of: viewModel.isBottomSheetPresented, perform: { isBottomSheetPresented in
				if isBottomSheetPresented == false {
					viewModel.onBottomSheetClose()
				}
			})
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
