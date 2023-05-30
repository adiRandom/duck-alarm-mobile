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
	var fontWeight: Font.Weight? = nil
	var isPrimaryColor: Bool = false

	init(_ text: String,
	     isDisabled: Bool = false,
		 fontSize: CGFloat,
	     fontWeight: Font.Weight = .regular,
	     isPrimaryColor: Bool = false)
	{
		self.text = text
		self.isDisabled = isDisabled
		self.fontSize = fontSize
		self.fontWeight = fontWeight
		self.isPrimaryColor = isPrimaryColor
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
		} else if isPrimaryColor{
			if isDarkMode {
				return Theme.PRIMARY_COLOR_DARK
			} else {
				return Theme.PRIMARY_COLOR
			}
		} else{
			return nil
		}
	}

	private func getFont() -> Font {
		if let fontStyle {
			return fontStyle
		} else if let fontSize {
			return .system(size: fontSize, weight: fontWeight)
		} else {
			return .body
		}
	}

	var body: some View {
		Text(text).foregroundColor(getTextColor()).font(getFont())
	}
	
	static let DEFAULT_SIZE = 17.0
}

struct ThemedText_Previews: PreviewProvider {
	static var previews: some View {
		ThemedText("Hello World", isDisabled: true)
	}
}
