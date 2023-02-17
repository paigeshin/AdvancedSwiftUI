#  Custom Navigation

### CustomNavBarView

```swift
import SwiftUI

struct CustomNavBarView: View {
    
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    var body: some View {
        HStack {
            if self.showBackButton {
                self.backButton
            }
            Spacer()
            self.titleSection
            Spacer()
            if self.showBackButton {
                self.backButton
                    .opacity(0)
            }
        } //: HSTACK
        .padding()
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)

    }
    
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(showBackButton: true, title: "", subtitle: "")
            Spacer()
        } //: VSTACK
    }
}

extension CustomNavBarView {
    
    private var backButton: some View {
        Button {
            self.dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: 4) {
            Text(self.title)
                .font(.title)
                .fontWeight(.semibold)
            if let subtitle: String {
                Text(subtitle)
            }
        } //: VSTACK
    }
    
}

```

### CustomNavBarContainerView

```swift
import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = ""
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: self.showBackButton,
                             title: self.title,
                             subtitle: self.subtitle)
            self.content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } //: VSTACK
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self) { title in
            self.title = title
        }
        .onPreferenceChange(CustomNavBarSubTitlePreferenceKey.self) { subtitle in
            self.subtitle = subtitle
        }
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self) { hidden in
            self.showBackButton = !hidden
        }
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            ZStack {
                Color
                    .green
                    .ignoresSafeArea()
                Text("Hello, world!")
                    .foregroundColor(.white)
            }
        }
    }
}

```

### CustomNavView

```swift
import SwiftUI

struct CustomNavView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                self.content
            }
            .navigationBarHidden(true)
        } //: NavigationView
        .navigationViewStyle(.stack)
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            Color.red.ignoresSafeArea()
        }
    }
}

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = nil 
    }
    
}

```

### CustomNavLink
```swift
struct CustomNavLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(
            destination: CustomNavBarContainerView(content: {
                self.destination
            })
            .navigationBarHidden(true),
            label: {
                self.label
            }
        )
    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            CustomNavLink(
                destination: Text("Destination"),
                label: { Text("Navigate")})
        }
    }
}

```

### CustomNavPreferenceKey

```swift
import SwiftUI

// showBackButton
// title
// subtitle

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}

struct CustomNavBarSubTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
    
}

struct CustomNavBarBackButtonHiddenPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
    
}

extension View {
    
    func customNavigationTitle(_ title: String) -> some View {
        self
            .preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
    
    func customNavigationSubtitle(_ subtitle: String?) -> some View {
        self
            .preference(key: CustomNavBarSubTitlePreferenceKey.self, value: subtitle)
    }
    
    func customNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        self
            .preference(key: CustomNavBarBackButtonHiddenPreferenceKey.self, value: hidden)
    }
    
    func customNavBarItems(title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        self
            .customNavigationTitle(title)
            .customNavigationSubtitle(subtitle)
            .customNavigationBarBackButtonHidden(backButtonHidden)
    }
    
}

```

### Usage

```swift
import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color
                    .orange
                    .ignoresSafeArea()
                
                CustomNavLink(
                    destination: Text("Destination"),
                    label: { Text("Navigate") }
                )
            }
            .customNavigationTitle("Custom Title!")
            .customNavigationSubtitle("Hello!")
        }
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}

```
