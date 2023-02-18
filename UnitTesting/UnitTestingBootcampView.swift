//
//  UnitTestingBootcampView.swift
//  Advanced
//
//  Created by paige shin on 2023/02/18.
//

import SwiftUI
import Combine



class UnitTestingBootcampViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    private var cancellables: Set<AnyCancellable> = []
    
    let dataService: NewDataServiceProtocol
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = self.dataArray.first(where: { $0 == item }) {
            self.selectedItem = x
        } else {
            self.selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = self.dataArray.first(where: { $0 == item }) {
            print("Save Item here!!! \(x)")
        } else {
            throw DataError.itemNotFound
        }
        
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping() {
        self.dataService.downloadItemsWithEsacping { items in
            self.dataArray = items
        }
    }
    
    func downloadWithCombine() {
        self.dataService.downloadItemsWithCombine()
            .sink { completion in
                dump(completion)
            } receiveValue: { items in
                self.dataArray = items
            }
            .store(in: &cancellables)

    }
    
}

