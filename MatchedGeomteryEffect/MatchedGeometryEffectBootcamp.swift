//
//  MatchedGeometryEffect.swift
//  Advanced
//
//  Created by paige shin on 2023/02/13.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !self.isClicked {
                Circle()
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: "rectangle", in: self.namespace)
            }
            
            Spacer()
            
            if self.isClicked {
                Circle()
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: "rectangle", in: self.namespace)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                self.isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffectExample2: View {
    
    let categories: [String] = [
        "Home",
        "Popular",
        "Saved"
    ]
    
    @State private var selected: String = ""
    @Namespace private var namespace
    
    var body: some View {
        HStack {
            ForEach(self.categories, id: \.self) { category in
                ZStack {
                    if self.selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.red.opacity(0.3))
                            .matchedGeometryEffect(id: "category", in: self.namespace)
                            .frame(width: 35, height: 2)
                            .offset(y: 10)
                    }
                    
                    Text(category)
                        .foregroundColor(self.selected == category ? .red : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        self.selected = category
                    }
                }
            }
        }
        .padding()
    }
    
}

struct MatchedGeometryEffectBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectExample2()
    }
}
