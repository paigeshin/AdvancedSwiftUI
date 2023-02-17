#  Animatable Custom Shape

```swift
import SwiftUI

struct AnimatableDataBootcamp: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            //            RoundedRectangle(cornerRadius: self.animate ? 60 : 0)
            //                .frame(width: 250, height: 250)
            
            //            RectangleWithSingleCornerAnimation(cornerRadius: self.animate ? 60 : 0)
            //                .frame(width: 250, height: 250)
            Pacman(offsetAmount: self.animate ? 20 : 0)
                .frame(width: 250, height: 250)
        }
        .onAppear {
            withAnimation(.linear(duration: 2.0).repeatForever()) {
                self.animate.toggle()
            }
        }
    }
}

struct RectangleWithSingleCornerAnimation: Shape {
    
    var cornerRadius: CGFloat = 60
    
    var animatableData: CGFloat {
        get { self.cornerRadius }
        set { self.cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - self.cornerRadius))
            
            path.addArc(
                center: CGPoint(x: rect.maxX - self.cornerRadius, y: rect.maxY - self.cornerRadius),
                radius: self.cornerRadius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: false
            )
            
            path.addLine(to: CGPoint(x: rect.maxX - self.cornerRadius, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
    
}

struct Pacman: Shape {
    
    var offsetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { self.offsetAmount }
        set { self.offsetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: self.offsetAmount),
                endAngle: Angle(degrees: 360 - self.offsetAmount),
                clockwise: false
            )
        }
    }
    
}

```

