//
//  ContentView.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 14.05.2023.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var viewModel = ContentViewViewModel()

	var body: some View {
		NavigationStack {
			VStack {
				if viewModel.alarms.isEmpty {
					ThemedText("No alarms set yet", fontStyle: .title2, isDisabled: true)
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
				AddAlarmBottomSheet(alarmModel: viewModel.selectedAlarmModel)
					.presentationDragIndicator(.visible)
					.presentationDetents([.medium])
					
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
