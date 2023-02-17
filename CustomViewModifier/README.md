#  Custom View Modifier

```swift

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
    
}

extension View {
    
    func withDefaultButtonFormatting() -> some View {
        self
            .modifier(DefaultButtonViewModifier())
    }
    
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack {
            
            Text("Hello World!")
                .withDefaultButtonFormatting()
            
        }
    }
}

struct ViewModifierBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootcamp()
    }
}


```

