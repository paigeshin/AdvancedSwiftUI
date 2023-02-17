#  UIViewRepresentable

```swift
import SwiftUI

// Convert a UIView from UIKit to SwiftUI 
struct UIViewRepresentableBootcamp: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(self.text)
            
            HStack {
                
                Text("SwiftUI: ")
                
                TextField("Type here...", text: self.$text)
                    .frame(height: 55)
                    .background(.gray)
            }
            
            HStack {
                
                Text("UIKit: ")
            
                UITextFieldViewRepresentable(text: self.$text,
                                             placeholder: "New Placeholder!!!",
                                             placeholderColor: .blue)
                .updatePlaceHolder("Hello World")
                .frame(height: 55)
                .background(.gray)
            }
            
        } //: VSTACK
        
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String, placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textfield: UITextField = self.getTextField()
        textfield.delegate = context.coordinator
        return textfield
    }
    
    // From SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textfield = UITextField(frame: .zero)
        let placeholder = NSAttributedString(
            string: self.placeholder,
            attributes: [
                .foregroundColor: self.placeholderColor
            ]
        )
        textfield.attributedPlaceholder = placeholder
        return textfield
    }
    
    // Modifier
    func updatePlaceHolder(_ text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    // From UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: self.$text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.text = textField.text ?? ""
        }
        
    }
    
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

struct UIViewRepresentableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableBootcamp()
    }
}

```

