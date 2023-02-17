//
//  PreferenceKeyBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/16.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
    
    @State private var text = "hello world"
    
    var body: some View {
        NavigationView {
            VStack {
//                SecondaryScreen(text: self.text)
//                    .navigationTitle("Navigation Title")
//                    .customTitle(text: "New Value!!!")
//                    .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
                
                ThirdScreen(text: self.text)
            }
        }
        // WATCHING IT
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            self.text = value
        }
    }
}

extension View {
    
    func customTitle(text: String) -> some View {
        self
            .preference(key: CustomTitlePreferenceKey.self, value: text)
    }
    
}

struct PreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyBootcamp()
    }
}


struct SecondaryScreen: View {
    
    let text: String
    
    var body: some View {
        Text(self.text)
    }
    
}

struct CustomTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}

/// ---------------------
struct ThirdScreen: View {
    
    let text: String
    @State private var newValue = ""
    
    var body: some View {
        Text(self.text)
            .onAppear {
                self.getDataFromDatabase()
            }
            .customTitle(text: self.newValue)
    }
    
    func getDataFromDatabase() {
        
        // download
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "NEW VALUE FROM DATABASE"
        }
        
    }
    
}
