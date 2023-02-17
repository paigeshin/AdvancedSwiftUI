#  ViewBuillder

```swift

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


```

