//
//  CustomNavBarView.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct CustomNavBarView: View {
    
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    var body: some View {
        HStack {
            if self.showBackButton {
                self.backButton
            }
            Spacer()
            self.titleSection
            Spacer()
            if self.showBackButton {
                self.backButton
                    .opacity(0)
            }
        } //: HSTACK
        .padding()
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)

    }
    
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(showBackButton: true, title: "", subtitle: "")
            Spacer()
        } //: VSTACK
    }
}

extension CustomNavBarView {
    
    private var backButton: some View {
        Button {
            self.dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: 4) {
            Text(self.title)
                .font(.title)
                .fontWeight(.semibold)
            if let subtitle: String {
                Text(subtitle)
            }
        } //: VSTACK
    }
    
}
