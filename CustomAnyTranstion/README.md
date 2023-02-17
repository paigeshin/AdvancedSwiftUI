#  CREATE CUSTOM TRANSITION

1. Define ViewModifier with effects you want to apply
    - rotationEffect
    - offset
    - opacity 
    - blur 
    - and so on ....
    
2. Extend AnyTranstion with ViewModifier created above 

    - AnyTransition.modifier(active: identity:)
        - active => changed value
        - identity => getting back to the original state 

```swift

//
//  AnyTransitionBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/13.
//

import SwiftUI

// (1) Define ViewModifier
struct RotateViewModifier: ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: self.rotation))
            .offset(x: self.rotation != 0 ? UIScreen.main.bounds.width : 0,
                    y: self.rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
    
}

// (2) extend ViewModifier to AnyTransition
extension AnyTransition {
    
    static var rotate: AnyTransition {
        AnyTransition
            .modifier(active: RotateViewModifier(rotation: 180),
                      identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotate(amount: Double) -> AnyTransition {
        AnyTransition.modifier(
            active: RotateViewModifier(rotation: amount),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    static var rotateOn: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .rotate,
            removal: .move(edge: .leading)
        )
    }
    
}

// (3) Use it

// .transition(AnyTransition.rotate.animation(.easeInOut))

struct AnyTransitionBootcamp: View {
    
    @State var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            
            Spacer()
            
            if self.showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .transition(AnyTransition.rotate.animation(.easeInOut))
//                    .transition(AnyTransition.rotate(amount: 1080))
//                    .transition(.move(edge: .leading))
//                    .transition(AnyTransition.scale)
                    .transition(.rotateOn)
            }
            
            
            Spacer()
            
            Text("Click Me!")
                .withDefaultButtonFormatting()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 5.0)) {
                        self.showRectangle.toggle()
                    }
                }
           
        }
//        .animation(.easeInOut, value: self.showRectangle)
    }
}

struct AnyTransitionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionBootcamp()
    }
}

```
