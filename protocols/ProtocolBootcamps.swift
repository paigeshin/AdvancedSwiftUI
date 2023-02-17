//
//  ProtocolBootcamps.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .orange
    let tertiary: Color = .green
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

struct ProtocolBootcamps: View {
    
    let colorTheme: ColorThemeProtocol = DefaultColorTheme()
    
    var body: some View {
        ZStack {
            self.colorTheme
                .tertiary
                .ignoresSafeArea()
            
            Text("Protocols are awesome!")
                .font(.headline)
                .foregroundColor(self.colorTheme.secondary)
                .padding()
                .background(self.colorTheme.primary)
                .cornerRadius(10)
            
        }
    }
}

struct ProtocolBootcamps_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolBootcamps()
    }
}
