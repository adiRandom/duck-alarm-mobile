//
//  ThemedText.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 23.05.2023.
//

import SwiftUI

struct ThemedText: View {
	@IsDarkMode var isDarkMode
	var text: String
	var fontSize: CGFloat? = nil
	var fontStyle: Font? = nil
	var fontWeight: Font.Weight? = nil
	var textColor: ThemeColor? = nil
	
	init(_ text: String){
		self.text = text
	}

	@available(*, deprecated, message: "Use the color init")
	init(_ text: String,
	     isDisabled: Bool = false,
	     fontSize: CGFloat,
	     fontWeight: Font.Weight = .regular,
	     isPrimaryColor: Bool = false)
	{
		self.text = text

		if isPrimaryColor {
			textColor = .Primary
		}

		if isDisabled {
			textColor = .Disabled
		}

		self.fontSize = fontSize
		self.fontWeight = fontWeight
	}

	@available(*, deprecated, message: "Use the color init")
	init(_ text: String, fontStyle: Font = .body, isDisabled: Bool = false) {
		self.text = text

		if isDisabled {
			textColor = .Disabled
		}

		self.fontStyle = fontStyle
	}

	init(_ text: String,
	     fontSize: CGFloat,
	     fontWeight: Font.Weight = .regular,
	     textColor: ThemeColor? = nil)
	{
		self.text = text
		self.textColor = textColor
		self.fontSize = fontSize
		self.fontWeight = fontWeight
	}
	
	init(_ text: String, fontStyle: Font = .body,   textColor: ThemeColor? = nil) {
		self.text = text
		self.textColor = textColor
		self.fontStyle = fontStyle
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
		Text(text).foregroundColor(textColor?.resolveColor(isDarkTheme: isDarkMode)).font(getFont())
	}

	static let DEFAULT_SIZE = 17.0
}

struct ThemedText_Previews: PreviewProvider {
	static var previews: some View {
		ThemedText("Hello World", isDisabled: true)
	}
}
