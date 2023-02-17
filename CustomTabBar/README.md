#  Custom TabBar



 1. define tabbar model
 
 2. create tabbar view
 
 3. create tabbar container which contains tabbar view
 
 4. tabbar items preferences to populate items
```swift 
  struct TabBarItemsPreference: PreferenceKey {
      
      static var defaultValue: [TabBarItem] = []
      
      static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
          value += nextValue()
      }
      
  }

  struct TabBarItemViewModifier: ViewModifier {
      
      let tab: TabBarItem
      @Binding var selection: TabBarItem
      
      func body(content: Content) -> some View {
          content
              .opacity(self.selection == self.tab ? 1 : 0)
              .preference(key: TabBarItemsPreference.self, value: [self.tab])
      }
      
  }

  extension View {
      
      func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
          self
              .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
      }
      
  }
  */
 ```
 
 5. USE
 
 ```swift
 struct AppTabBarView: View {
     
     @State private var tabSelection: TabBarItem = .home
     
     var body: some View {
         CustomTabBarContainerView(selection: self.$tabSelection) {
             Color
                 .blue
                 .tabBarItem(
                     tab: .home,
                     selection: self.$tabSelection
                 )
             
             Color
                 .red
                 .tabBarItem(
                     tab: .favorites,
                     selection: self.$tabSelection
                 )
             
             Color
                 .green
                 .tabBarItem(
                     tab: .profile,
                     selection: self.$tabSelection
                 )
             
         }
     }
 }
 
 */
```

### TabBar item

```swift
enum TabBarItem: Hashable {
    case home, favorites, profile
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        }
    }
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }
    var color: Color {
        switch self {
        case .home: return .red
        case .favorites: return .blue
        case .profile: return .green
        }
    }
}


```


### Custom TabBar

```swift
struct CustomTabBar: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
     
    var body: some View {
        self.tabBarVersion2
            .animation(.easeInOut, value: self.selection)
    }
    
    private var tabBarVersion1: some View {
        HStack {
            ForEach(self.tabs, id: \.self) { tab in
                self.tabView(tab: tab)
                    .onTapGesture {
                        self.switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(
            Color.white
        )
    }
    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(self.selection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(self.selection == tab ? tab.color.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(self.tabs, id: \.self) { tab in
                self.tabView2(tab: tab)
                    .onTapGesture {
                        self.switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
    private func tabView2(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(self.selection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if self.selection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: self.namespace)
                }
            }
        )
        
    }
    
    
    private func switchToTab(tab: TabBarItem) {
        self.selection = tab
    }
    
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBar(tabs: [.home, .favorites, .profile], selection: .constant(.home))
        }
    }
}


```

### CustomTabBarContainer
```swift
import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            CustomTabBar(tabs: self.tabs, selection: self.$selection)
        }
        .onPreferenceChange(TabBarItemsPreference.self) { tabs in
            self.tabs.append(contentsOf: tabs)
        }
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(.home), content: {
            Color.red
        })
    }
}



```

### Custom TabBar PreferenceKey

```swift
struct TabBarItemsPreference: PreferenceKey {
    
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
    
}

struct TabBarItemViewModifier: ViewModifier {
    
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(self.selection == self.tab ? 1 : 0)
            .preference(key: TabBarItemsPreference.self, value: [self.tab])
    }
    
}

extension View {
    
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        self
            .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
    
}

```

### AppTabBarView

```swift
import SwiftUI

struct AppTabBarView: View {
    
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: self.$tabSelection) {
            Color
                .blue
                .tabBarItem(
                    tab: .home,
                    selection: self.$tabSelection
                )
            
            Color
                .red
                .tabBarItem(
                    tab: .favorites,
                    selection: self.$tabSelection
                )
            
            Color
                .green
                .tabBarItem(
                    tab: .profile,
                    selection: self.$tabSelection
                )
            
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}


```
