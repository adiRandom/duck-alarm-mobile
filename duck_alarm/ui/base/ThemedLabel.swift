//
//  ThemedLabel.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 23.05.2023.
//

import SwiftUI

struct ThemedLabel: View {
	var text: String
	var systemIcon: String
	var body: some View {
		Label(text, systemImage: systemIcon).foregroundColor(Theme.PRIMARY_COLOR)
	}
}

struct ThemedLabel_Previews: PreviewProvider {
	static var previews: some View {
		ThemedLabel(text: "Add item", systemIcon: "plus")
	}
}
