//
//  CustomShapeBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/13.
//

import SwiftUI

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // 꼭짓점 A
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // 꼭짓점 B (BOTTOM RIGHT)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // 꼭짓점 C (BOTTOM LEFT)
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY)) // Always close where it started
        }
    }
    
}

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY)) // Always close where it started
        }
    }
    
}



struct CustomShapeBootcamp: View {
    var body: some View {
        ZStack {

            Diamond()
                .frame(width: 300, height: 300)
            
//             Image("img")
//                .resizable()
//                .scaledToFill()
//                .frame(width: 300, height: 300)
//                .clipShape(
//                    Triangle()
//                        .rotation(Angle(degrees: 180))
//                )
            
//            Triangle()
//                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [5]))
//                .trim(from: 0, to: 0.5)
//                .fill(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
//                .frame(width: 300, height: 300)
            
//            Rectangle()
//                .trim(from: 0, to: 0.5)
//                .frame(width: 300, height: 300)
            
        }
    }
}

struct CustomShapeBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapeBootcamp()
    }
}
