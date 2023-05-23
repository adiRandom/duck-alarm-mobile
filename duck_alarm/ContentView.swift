//
//  ContentView.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 14.05.2023.
//

import SwiftUI

struct ContentView: View {
	@State var alarms: [AlarmModel] = []

	func addAlarm() {}

	var body: some View {
		NavigationStack {
			VStack {
				if alarms.isEmpty {
					ThemedText("No alarms set yet", fontStyle: .title2, isDisabled: true)
				}
			}
			.navigationTitle("Alarms")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: addAlarm) {
						ThemedLabel(text: "Add Item", systemIcon: "plus").foregroundColor(.red)
					}
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
