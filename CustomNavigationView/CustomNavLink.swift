//
//  CustomNavLink.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(
            destination: CustomNavBarContainerView(content: {
                self.destination
            })
            .navigationBarHidden(true),
            label: {
                self.label
            }
        )
    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            CustomNavLink(
                destination: Text("Destination"),
                label: { Text("Navigate")})
        }
    }
}
