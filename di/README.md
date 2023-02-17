#  DI

```swift

import SwiftUI
import Combine

struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ProductionDataService: DataServiceProtocol {

    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: self.url)
            .map({$0.data})
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
}

class DependencyInjectionViewModel: ObservableObject {
    
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        self.loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { posts in
                self.dataArray = posts
            }
            .store(in: &self.cancellables)

    }
    
}

class MockDataService: DataServiceProtocol {
    
    let testData: [PostsModel] = [
        PostsModel(userId: 1, id: 1, title: "One", body: "one"),
        PostsModel(userId: 2, id: 2, title: "Two", body: "two"),
    ]
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
//            .setFailureType(to: Error.self)
            .tryMap { $0 }
            .eraseToAnyPublisher()
    }
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

struct DIBootcamp: View {
    
    @StateObject var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        self._vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.vm.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

struct DIBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DIBootcamp(dataService: MockDataService())
    }
}

```

