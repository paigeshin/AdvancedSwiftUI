//
//  CustomTabBar.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct CustomTabBar: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
     
    var body: some View {
        self.tabBarVersion2
            .animation(.easeInOut, value: self.selection)
    }
    
    private var tabBarVersion1: some View {
        HStack {
            ForEach(self.tabs, id: \.self) { tab in
                self.tabView(tab: tab)
                    .onTapGesture {
                        self.switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(
            Color.white
        )
    }
    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(self.selection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(self.selection == tab ? tab.color.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(self.tabs, id: \.self) { tab in
                self.tabView2(tab: tab)
                    .onTapGesture {
                        self.switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
    private func tabView2(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(self.selection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if self.selection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: self.namespace)
                }
            }
        )
        
    }
    
    
    private func switchToTab(tab: TabBarItem) {
        self.selection = tab
    }
    
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBar(tabs: [.home, .favorites, .profile], selection: .constant(.home))
        }
    }
}

