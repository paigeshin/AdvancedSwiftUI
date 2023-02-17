//
//  GeometryPreferenceKeyBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/16.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hello World")
                .frame(width: self.rectSize.width, height: self.rectSize.height)
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)
                        .overlay(
                            Text("\(geo.size.width)")
                                .foregroundColor(.white)
                        )
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometryPreferenceKey.self) { value in
            self.rectSize = value
        }
    }
}

struct GeometryPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyBootcamp()
    }
}

extension View {
    
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        self
            .preference(key: RectangleGeometryPreferenceKey.self, value: size)
    }
    
}

struct RectangleGeometryPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
    
}
