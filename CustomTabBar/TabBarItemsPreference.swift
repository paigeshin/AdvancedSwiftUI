//
//  TabBarItmesPreferenceKey.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct TabBarItemsPreference: PreferenceKey {
    
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
    
}

struct TabBarItemViewModifier: ViewModifier {
    
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(self.selection == self.tab ? 1 : 0)
            .preference(key: TabBarItemsPreference.self, value: [self.tab])
    }
    
}

extension View {
    
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        self
            .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
    
}
