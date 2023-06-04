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

	// TODO: No data when starting the app
	@FetchRequest(sortDescriptors: [SortDescriptor(\.isPm), SortDescriptor(\.hour), SortDescriptor(\.minute)])
	private var alarmEntities: FetchedResults<AlarmEntity>
	private var alarms: [AlarmModel] { alarmEntities.map { entity in entity.toModel() }}

	var body: some View {
		NavigationStack {
			VStack {
				if alarms.isEmpty {
					ThemedText("No alarms set yet", fontStyle: .title2, isDisabled: true)
				} else {
					ForEach(alarms) { alarm in
						AlarmView(alarm: alarm) {
							alarm in viewModel.updateAlarm(alarmModel: alarm)
							
						}
					}
					Spacer()
				}
			}
			.navigationTitle("Alarms")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: viewModel.addAlarm) {
						ThemedLabel(text: "Add Item", systemIcon: "plus").foregroundColor(.red)
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
				.presentationDetents([.medium])
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
