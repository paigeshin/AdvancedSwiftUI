//
//  AppTabBarView.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: self.$tabSelection) {
            Color
                .blue
                .tabBarItem(
                    tab: .home,
                    selection: self.$tabSelection
                )
            
            Color
                .red
                .tabBarItem(
                    tab: .favorites,
                    selection: self.$tabSelection
                )
            
            Color
                .green
                .tabBarItem(
                    tab: .profile,
                    selection: self.$tabSelection
                )
            
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}

