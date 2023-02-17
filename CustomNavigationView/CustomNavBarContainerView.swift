//
//  CustomNavBarContainerView.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = ""
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: self.showBackButton,
                             title: self.title,
                             subtitle: self.subtitle)
            self.content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } //: VSTACK
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self) { title in
            self.title = title
        }
        .onPreferenceChange(CustomNavBarSubTitlePreferenceKey.self) { subtitle in
            self.subtitle = subtitle
        }
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self) { hidden in
            self.showBackButton = !hidden
        }
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            ZStack {
                Color
                    .green
                    .ignoresSafeArea()
                Text("Hello, world!")
                    .foregroundColor(.white)
            }
        }
    }
}
