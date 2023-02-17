//
//  GenericsBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/16.
//

import SwiftUI

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}


struct GenericsBootcamp<T: View>: View {
    
    let content: T
    let title: String
    
    var body: some View {
        VStack {
            Text(self.title)
            self.content
        }
    }
    
}

struct GenericsBootcamp_Previews: PreviewProvider {
    
    static var previews: some View {
        GenericsBootcamp(content: EmptyView(), title: "Hello World")
    }
    
}
