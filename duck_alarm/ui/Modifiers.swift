//
//  Modifiers.swift
//  duck_alarm
//
//  Created by Adrian Pascu on 01.06.2023.
//

import SwiftUI

struct Modifiers: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension View{
	func border(width:CGFloat, color: Color, cornerRadius: CGFloat) -> some View{
		return overlay(
			RoundedRectangle(cornerRadius: cornerRadius)
				.stroke(color, lineWidth: width)
		)
	}
}
