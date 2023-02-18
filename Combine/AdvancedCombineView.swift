//
//  AdvancedCombineView.swift
//  Advanced
//
//  Created by paige shin on 2023/02/18.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
//    @Published var basicPublisher: String = "first publish"
//    let currentValuePublisher = CurrentValueSubject<Int, Never>("first publish")
    let passthroughPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        self.publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = Array(0...10)
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) { [weak self] in
                self?.passthroughPublisher.send(items[x])
                
                if x == items.indices.last {
                    // Some Operator works only when `.finished` is sent
                    self?.passthroughPublisher.send(completion: .finished)
                }
            }
        }
    }
    
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var error: String = "" 
    let dataService = AdvancedCombineDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
//        let sharedPublihser = self.dataService.passthroughPublisher
//            .dropFirst(3)
//            .share()
//
//        sharedPublihser
//            .map { String($0) }
//            .sink(receiveCompletion: <#T##((Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void)##((Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void)##(Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void#>, receiveValue: <#T##((String) -> Void)##((String) -> Void)##(String) -> Void#>)
//
//        sharedPublihser
//            .map { String($0) }
//            .sink(receiveCompletion: <#T##((Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void)##((Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void)##(Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void#>, receiveValue: <#T##((String) -> Void)##((String) -> Void)##(String) -> Void#>)
        
//        let sharedPublihser = self.dataService.passthroughPublisher
//            .dropFirst(3)
//            .share()
//            .multicast(subject: PassthroughSubject<Int, Never>())
//
//        sharedPublihser
//            .map { String($0) }
//            .sink(receiveCompletion: <#T##((Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void)##((Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void)##(Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void#>, receiveValue: <#T##((String) -> Void)##((String) -> Void)##(String) -> Void#>)
//            .store(in: <#T##C#>)
//
//        sharedPublihser
//            .map { String($0) }
//            .sink(receiveCompletion: <#T##((Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void)##((Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void)##(Subscribers.Completion<Publishers.Share<Publishers.Drop<PassthroughSubject<Int, Error>>>.Failure>) -> Void#>, receiveValue: <#T##((String) -> Void)##((String) -> Void)##(String) -> Void#>)
//            .store(in: <#T##C#>)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            sharedPublihser
//                .connect()
//                .store(in: <#T##C#>)
//        }
        
        self.dataService
            .passthroughPublisher
        
            // MARK: Sequence Operations
//            .first()
//            .first(where: <#T##(Int) -> Bool#>)
        
            // try map => throwable
            // try first => throwable
//            .tryFirst(where: { int in
//                if int == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            }) // publish one value and when it encounters error it stops emitting
        
//            .last() // publish last element => should finish
//            .last(where: <#T##(Int) -> Bool#>)
//            .tryLast(where: { int in
//                if int == 13 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
        
        // Userful when you set default value
//            .dropFirst()
        // Drop First Three Elements
//            .dropFirst(3)
        // Drop less than 3
//            .drop(while: { $0 < 3 })
//            .tryDrop(while: { int in
//                if int == 15 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 6
//            })
//            .prefix(4)
//            .prefix(while: <#T##(Int) -> Bool#>)
//            .tryPrefix(while: <#T##(Int) throws -> Bool#>)
            
//            .output(at: <#T##Int#>)
//            .output(in: <#T##RangeExpression#>)
        
            // MARK: Mathematic Operations
//            .max()
//            .max(by: <#T##(Int, Int) -> Bool#>)
//            .tryMax(by: <#T##(Int, Int) throws -> Bool#>)
            
//            .min()
//            .min(by: <#T##(Int, Int) -> Bool#>)
//            .tryMin(by: <#T##(Int, Int) throws -> Bool#>)
            
            // MARK: Filter / Reducing Operations
//            .map { String($0) }
//            .tryMap(<#T##transform: (Int) throws -> T##(Int) throws -> T#>) // Stops when error occurred
          
//            .compactMap(<#T##transform: (Int) -> T?##(Int) -> T?#>)
//            .tryCompactMap(<#T##transform: (Int) throws -> T?##(Int) throws -> T?#>)
        
//            .filter(<#T##isIncluded: (Int) -> Bool##(Int) -> Bool#>)
//            .tryFilter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)
        
//            .removeDuplicates()
//            .removeDuplicates(by: <#T##(Int, Int) -> Bool#>)
//            .tryRemoveDuplicates(by: <#T##(Int, Int) throws -> Bool#>)
            
//            .replaceNil(with: <#T##T#>)
//            .replaceError(with: <#T##Int#>)
//            .replaceEmpty(with: <#T##Int#>)
        
//            .scan(<#T##initialResult: T##T#>, <#T##nextPartialResult: (T, Int) -> T##(T, Int) -> T#>)
//            .scan(0, +)
//            .tryScan(<#T##initialResult: T##T#>, <#T##nextPartialResult: (T, Int) throws -> T##(T, Int) throws -> T#>)
        
//            .reduce(<#T##initialResult: T##T#>, <#T##nextPartialResult: (T, Int) -> T##(T, Int) -> T#>)
        
//            .map(<#T##keyPath: KeyPath<Int, T>##KeyPath<Int, T>#>)
//            .collect()
//            .collect(<#T##count: Int##Int#>)
//            .collect(<#T##strategy: Publishers.TimeGroupingStrategy<Scheduler>##Publishers.TimeGroupingStrategy<Scheduler>#>)
        
//            .allSatisfy(<#T##predicate: (Int) -> Bool##(Int) -> Bool#>)
//            .tryAllSatisfy(<#T##predicate: (Int) throws -> Bool##(Int) throws -> Bool#>)
        

            // MARK: Timing Operations
//            .debounce(for: <#T##SchedulerTimeIntervalConvertible & Comparable & SignedNumeric#>, scheduler: <#T##Scheduler#>)
        
//            .delay(for: <#T##SchedulerTimeIntervalConvertible & Comparable & SignedNumeric#>, scheduler: <#T##Scheduler#>)
        
//            .measureInterval(using: <#T##Scheduler#>, options: <#T##Scheduler.SchedulerOptions?#>)
//            .measureInterval(using: DispatchQueue.main)
//            .map({ stride in
//                return "\(stride.timeInterval)" // => Nano Seconds
//            })
        
//            .throttle(for: <#T##SchedulerTimeIntervalConvertible & Comparable & SignedNumeric#>, scheduler: <#T##Scheduler#>, latest: <#T##Bool#>)
        
            // MARK: Multiple Publishers / Subscribers
//            .combineLatest(<#T##other: Publisher##Publisher#>)
            
//            .merge(with: <#T##Publisher#>)
        
//            .zip(<#T##other: Publisher##Publisher#>, <#T##transform: (Int, Publisher.Output) -> T##(Int, Publisher.Output) -> T#>)
        
//            .catch(<#T##handler: (Error) -> Publisher##(Error) -> Publisher#>)
        
        
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] item in
                self?.data.append("\(item)")
            }
            .store(in: &self.cancellables)

    }
    
}


struct AdvancedCombineView: View {
    
    @StateObject private var vm = AdvancedCombineBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.vm.data, id: \.self) { item in
                    Text(item)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                if !self.vm.error.isEmpty {
                    Text(self.vm.error)
                }
                
            }
        }
    }
}

struct AdvancedCombineView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineView()
    }
}
