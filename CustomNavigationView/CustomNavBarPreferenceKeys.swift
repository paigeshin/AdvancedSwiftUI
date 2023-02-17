//
//  CustomNavBarPreferenceKeys.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

// showBackButton
// title
// subtitle

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}

struct CustomNavBarSubTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
    
}

struct CustomNavBarBackButtonHiddenPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
    
}

extension View {
    
    func customNavigationTitle(_ title: String) -> some View {
        self
            .preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
    
    func customNavigationSubtitle(_ subtitle: String?) -> some View {
        self
            .preference(key: CustomNavBarSubTitlePreferenceKey.self, value: subtitle)
    }
    
    func customNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        self
            .preference(key: CustomNavBarBackButtonHiddenPreferenceKey.self, value: hidden)
    }
    
    func customNavBarItems(title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        self
            .customNavigationTitle(title)
            .customNavigationSubtitle(subtitle)
            .customNavigationBarBackButtonHidden(backButtonHidden)
    }
    
}
