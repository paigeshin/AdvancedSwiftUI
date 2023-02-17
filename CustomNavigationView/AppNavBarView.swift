//
//  AppNavBarView.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color
                    .orange
                    .ignoresSafeArea()
                
                CustomNavLink(
                    destination: Text("Destination"),
                    label: { Text("Navigate") }
                )
            }
            .customNavigationTitle("Custom Title!")
            .customNavigationSubtitle("Hello!")
        }
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}
