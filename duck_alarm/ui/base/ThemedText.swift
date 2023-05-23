//
//  ThemedText.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 23.05.2023.
//

import SwiftUI

struct ThemedText: View {
	@IsDarkMode var isDarkMode
	var isDisabled: Bool
	var text: String
	var fontSize: CGFloat? = nil
	var fontStyle: Font? = nil

	init(_ text: String, isDisabled: Bool = false, fontSize: CGFloat) {
		self.text = text
		self.isDisabled = isDisabled
		self.fontSize = fontSize
	}

	init(_ text: String, fontStyle: Font = .body, isDisabled: Bool = false) {
		self.text = text
		self.isDisabled = isDisabled
		self.fontStyle = fontStyle
	}

	private func getTextColor() -> Color? {
		if isDisabled {
			if isDarkMode {
				return Theme.DISABLED_DARK
			} else {
				return Theme.DISABLED_LIGHT
			}
		} else {
			return nil
		}
	}

	private func getFont() -> Font {
		if let fontStyle {
			return fontStyle
		} else if let fontSize {
			return .system(size: fontSize)
		} else {
			return .body
		}
	}

	var body: some View {
		Text(text).foregroundColor(getTextColor()).font(getFont())
	}
}

struct ThemedText_Previews: PreviewProvider {
	static var previews: some View {
		ThemedText("Hello World", isDisabled: true)
	}
}
