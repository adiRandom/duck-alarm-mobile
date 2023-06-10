//
//  PrimaryButton.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 10.06.2023.
//

import SwiftUI

struct PrimaryButton: View {
	private var text: String
	private var action: ()->Void

	init(_ text: String, action: @escaping ()->Void) {
		self.text = text
		self.action = action
	}

	var body: some View {
		Button(text) {
			action()
		}
	}
}

struct PrimaryButton_Previews: PreviewProvider {
	static var previews: some View {
		PrimaryButton("Press Me"){
			
		}
	}
}

