//
//  UITestingBootcampView.swift
//  Advanced
//
//  Created by paige shin on 2023/02/18.
//

import SwiftUI

class UITestingViewModel: ObservableObject {
    
    let placeholderText: String = "Add your name..."
    @Published var textFieldText: String = ""
    @Published var currentUserIsSignedIn: Bool = false
    
    init(currentUserIsSignedIn: Bool) {
        self.currentUserIsSignedIn = currentUserIsSignedIn
    }
    
    func signUpButtonPressed() {
        guard !self.textFieldText.isEmpty else { return }
        self.currentUserIsSignedIn = true
    }
    
    
}

struct UITestingBootcampView: View {
    
    @StateObject var vm: UITestingViewModel
    
    init(currentUserIsSignedIn: Bool) {
        self._vm = StateObject(wrappedValue: UITestingViewModel(currentUserIsSignedIn: currentUserIsSignedIn))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ZStack {
                if self.vm.currentUserIsSignedIn {
                    SignedInHomeView()
                        .transition(.move(edge: .trailing))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                if !self.vm.currentUserIsSignedIn {
                    self.signUpLayer
                        .transition(.move(edge: .leading))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            } //: ZSTACK

            
        } //: ZSTACK
    }
}

struct UITestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        UITestingBootcampView(currentUserIsSignedIn: true)
    }
}

extension UITestingBootcampView {
    
    private var signUpLayer: some View {
        VStack {
            TextField(self.vm.placeholderText, text: self.$vm.textFieldText)
                .font(.headline)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .accessibilityIdentifier("SignUpTextField")
            
            Button {
                withAnimation(.spring()) {
                    self.vm.signUpButtonPressed()
                }
            } label: {
                Text("SIGN UP")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .accessibilityIdentifier("SignUpButton")

        } //: VSTACK
        .padding()
    }
    
}

struct SignedInHomeView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button {
                    self.showAlert = true
                } label: {
                    Text("Show welcome alert!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("ShowAlertButton")
                .alert(isPresented: self.$showAlert, content: {
                    return Alert(title: Text("Welcome to the app!"))
                })
                
                NavigationLink(destination: Text("Destination"),
                               label: {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                .accessibilityIdentifier("NavigationLinkToDestination")
                
                
            } //: VSTACK
            .padding()
            .navigationTitle("Welcome")
        }
    }
    
}
