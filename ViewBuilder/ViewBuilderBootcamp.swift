//
//  ViewBuilderBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/16.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(self.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                if let description {
                    Text(description)
                        .font(.callout)
                }
                
                if let iconName {
                    Image(systemName: iconName)
                }
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Spacer()
        }
    }
}

struct HeaderViewGeneric<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(self.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                self.content
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Spacer()
        }
    }
    
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            self.headerSection
        } //: VSTACK
    }
    
    /*
     You typically use ViewBuilder as a parameter attribute for child view-producing closure parameters, "allowing those closures to provide multiple child views".
     */
    /*
     Clients of this function can use multiple-statement closures to provide several child views, as shown in the following example:
     */
    // MARK: SUMMARY
    // 1 - Allow closures to provide multiple child views
    // 2 - Allow multiple-statement closures to provide several child views
    @ViewBuilder private var headerSection: some View {
        switch self.type {
        case .one:
            self.viewOne
        case .two:
            self.viewTwo
        case .three:
            self.viewThree
        }
    }
    
    private var viewOne: some View {
        Text("One!")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("TWO")
            Image(systemName: "heart.fill")
        } //: VSTACK
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
    
}

struct ViewBuilderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HeaderViewRegular(title: "New Title", description: "Hello", iconName: nil)
            HeaderViewRegular(title: "Another Title", description: nil, iconName: nil)
            Spacer()
        }
        
    }
}
