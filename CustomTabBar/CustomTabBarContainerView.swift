//
//  CustomTabBarContainerView.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            CustomTabBar(tabs: self.tabs, selection: self.$selection)
        }
        .onPreferenceChange(TabBarItemsPreference.self) { tabs in
            self.tabs.append(contentsOf: tabs)
        }
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(.home), content: {
            Color.red
        })
    }
}


