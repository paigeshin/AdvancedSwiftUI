//
//  UIViewControllerRepresentableBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/17.
//

import SwiftUI

struct UIViewControllerRepresentableBootcamp: View {
    
    @State var showScreen: Bool = false
    @State var image: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("hi")
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            Button {
                self.showScreen.toggle()
            } label: {
                Text("Click Here")
            }
//            .sheet(isPresented: self.$showScreen) {
//                BasicUIViewControllerRepresentable(labelText: "New Text Here")
//            }
            .sheet(isPresented: self.$showScreen) {
                UIImagePickerControllerRepresentable(image: self.$image, showScreen: self.$showScreen)
            }
            
        } //: VSTACK
    }
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: self.$image, showScreen: self.$showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newimage = info[.originalImage] as? UIImage else { return }
            self.image = newimage
            self.showScreen = false
        }
        
    }
    

}

struct UIViewControllerRepresentableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerRepresentableBootcamp()
    }
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    let labelText: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MyFirstViewController()
        vc.labelText = labelText
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

class MyFirstViewController: UIViewController {
    
    var labelText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .white
        
        view.addSubview(label)
        label.frame = view.frame
        
    }
    
}
