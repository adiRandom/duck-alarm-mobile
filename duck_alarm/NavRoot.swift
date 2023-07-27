//
//  NavRoot.swift
//  duck_alarm
//Na
//  Created by Adrian Pascu on 27.07.2023.
//

import SwiftUI

struct NavRoot: View {
	@EnvironmentObject var navController: NavController
    var body: some View {
		if navController.currentRoute == NavController.ALARM {
			DismissAlarmScreen()
		} else {
			ContentView()
		}
    }
}

struct NavRoot_Previews: PreviewProvider {
    static var previews: some View {
        NavRoot()
    }
}
