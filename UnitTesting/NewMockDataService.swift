//
//  NewMockDataService.swift
//  Advanced
//
//  Created by paige shin on 2023/02/18.
//

import Foundation
import Combine

protocol NewDataServiceProtocol {
    func downloadItemsWithEsacping(completion: @escaping(_ items: [String]) -> Void)
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServiceProtocol {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
            "ONE", "TWO", "THREE"
        ]
    }
    
    func downloadItemsWithEsacping(completion: @escaping(_ items: [String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(self.items)
            .tryMap({ items in
                guard !items.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return items
            })
            .eraseToAnyPublisher()
    }
    
}
