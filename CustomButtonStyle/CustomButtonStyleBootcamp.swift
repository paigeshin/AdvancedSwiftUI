//
//  CustomButtonStyleBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/13.
//

import SwiftUI

struct ButtonPressableStyle: ButtonStyle {
    
    let scaleAmount: CGFloat
        
    func makeBody(configuration: Configuration) -> some View {
        // sconfiguration.label // View
        // configuration.isPressed // Button State
        configuration
            .label
            .scaleEffect(configuration.isPressed ? self.scaleAmount : 1.0)
//            .brightness(configuration.isPressed ? 0.05 : 0)
//            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
    
}

extension View {
    
    func withPressableButtonStyle(scaledAmount: CGFloat = 0.9) -> some View {
        self.buttonStyle(ButtonPressableStyle(scaleAmount: scaledAmount))
    }
    
}

struct ButtonStyleBootcamp: View {
    
    var body: some View {
        Button {
            
        } label: {
            Text("Click Me")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
        }
        .withPressableButtonStyle()
        .padding(40)

    }
    
}

struct ButtonStyleBootcamp_Previews: PreviewProvider {
    
    static var previews: some View {
        ButtonStyleBootcamp()
    }
    
}
