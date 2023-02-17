//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/16.
//

import SwiftUI

struct ScrollViewOffsetPrefenrenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
}

extension View {
    
    // read current view's x offset relative to UIScreen from the scroll view
    func onScrollViewYOffsetChanged(action: @escaping(_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    // Get the exact offset of title view
                    Color
                        .clear
                        .preference(key: ScrollViewOffsetPrefenrenceKey.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPrefenrenceKey.self) { value in
                action(value)
            }
    }
    
    // read current view's y offset relative to UIScreen from the scroll view
    func onScrollViewXOffsetChanged(action: @escaping(_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    // Get the exact offset of title view
                    Color
                        .clear
                        .preference(key: ScrollViewOffsetPrefenrenceKey.self, value: geo.frame(in: .global).minX)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPrefenrenceKey.self) { value in
                action(value)
            }
    }
    
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    
    let title: String = "New Title Here!!!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
    
        ScrollView {
            VStack {
                self.titleLayer
                    // Fade Effect
                    .opacity(Double(self.scrollViewOffset) / 63.0)
                    .onScrollViewYOffsetChanged { offset in
                        self.scrollViewOffset = offset
                    }
                
                self.contentLayer
            }
            .padding()
        }
        .overlay(
            Text("\(self.scrollViewOffset)")
        )
        .overlay(
            self.navBarLayer
                .opacity(self.scrollViewOffset < 40 ? 1.0 : 0.0)
            ,alignment: .top
        )
        .animation(.default, value: self.scrollViewOffset)
        
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyBootcamp()
    }
}

extension ScrollViewOffsetPreferenceKeyBootcamp {
    
    private var titleLayer: some View {
        Text(self.title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<30) { _  in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 300)
        }
    }
    
    private var navBarLayer: some View {
        Text(self.title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
    
}
