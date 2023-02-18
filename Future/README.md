# Future

- emits `single value`
- finished immediately when emitted

```swift
import SwiftUI
import Combine

class FuturesBootcampViewModel: ObservableObject {
    
    @Published var title: String = "Starting Title"
    let url = URL(string: "https://www.google.com")!
    var cancellables = Set<AnyCancellable>()
    
    init() {
        self.download()
    }
    
    func download() {
//        self.getCombinePublisher()
//            .sink { _ in
//
//            } receiveValue: { [weak self] value in
//                self?.title = value
//            }
//            .store(in: &cancellables)
        
//        self.getEscapingClosure { [weak self] value, error in
//            self?.title = value
//        }
        
        self.getFuturePublisher()
            .sink { _ in
                
            } receiveValue: { value in
                self.title = value
            }
            .store(in: &cancellables)
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: self.url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map { _ in "New Value" }
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completionHandler: @escaping(_ value: String, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: self.url) { data, response, error in
            completionHandler("New Value 2", nil)
        }
        .resume()
    }
    
    // Future -> produces a single value and finishes
    func getFuturePublisher() -> Future<String, Error> {
        return Future { promise in
            self.getEscapingClosure { value, error in
                if let error {
                    promise(.failure(error))
                    return
                }
                promise(.success(value))
            }
        }
    }
    
    func doSomething(completion: @escaping(_ value: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion("NEW STRING")
        }
    }
    
    func doSomethingInTheFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
    
}

struct FuturesBootcamp: View {
    
    @StateObject var vm = FuturesBootcampViewModel()
    
    var body: some View {
        Text(self.vm.title)
    }
}

struct FuturesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FuturesBootcamp()
    }
}

```
