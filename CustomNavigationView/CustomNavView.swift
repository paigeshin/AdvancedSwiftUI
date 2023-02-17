//
//  CustomNavView.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                self.content
            }
            .navigationBarHidden(true)
        } //: NavigationView
        .navigationViewStyle(.stack)
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            Color.red.ignoresSafeArea()
        }
    }
}

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = nil 
    }
    
}
