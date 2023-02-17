//
//  TabBarItem.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

enum TabBarItem: Hashable {
    case home, favorites, profile
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        }
    }
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }
    var color: Color {
        switch self {
        case .home: return .red
        case .favorites: return .blue
        case .profile: return .green
        }
    }
}

