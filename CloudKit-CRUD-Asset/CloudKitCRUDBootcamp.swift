//
//  CloudKitCRUDBootcamp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/19.
//

import CloudKit
import SwiftUI

struct Fruit: Hashable {
    let name: String
    let imageURL: URL?
    let record: CKRecord
}

class CloudKitCRUDBootcampViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var fruits: [Fruit] = []
    
    init() {
        self.fetchItems()
    }
    
    func addButtonPressed() {
        guard !self.text.isEmpty else { return }
        self.addItem(name: self.text)
    }
    
    private func addItem(name: String) {
        let newFruit = CKRecord(recordType: "Fruits")
        newFruit["name"] = name
        
        guard
            let image = UIImage(named: "img"),
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("img.jpeg"),
            let data = image.jpegData(compressionQuality: 1.0)
        else { return }
        
        // MARK: SAVE FILE
        try? data.write(to: url)
        newFruit["image"] = CKAsset(fileURL: url)
        self.saveItem(record: newFruit)
    }
    
    
    
    private func saveItem(record: CKRecord) {
//        CKContainer.default().privateCloudDatabase
//        CKContainer.default().sharedCloudDatabase
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] record, error in
            print("Record: \(String(describing: record))")
            print("Error: \(String(describing: error))")
            
            DispatchQueue.main.async {
                self?.text = ""
                self?.fetchItems()
            }
        }
    }
    
    func fetchItems() {
        let predicate = NSPredicate(value: true)
//        let predicate = NSPredicate(format: "name = %@", argumentArray: ["Coconut"])
        let query = CKQuery(recordType: "Fruits", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let queryOperation = CKQueryOperation(query: query)
//        queryOperation.resultsLimit = 2
        
        var items: [Fruit] = []
        
        if #available(iOS 15.0, *) {
            queryOperation.recordMatchedBlock = { (recordID, result) in
                switch result {
                case .success(let record):
                    guard let name = record["name"] as? String else { return }
                    // Receive image
                    let imageAsset = record["image"] as? CKAsset
                    let imageURL = imageAsset?.fileURL
                    items.append(Fruit(name: name, imageURL: imageURL, record: record))
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error)")
                }
            }
        } else {
            queryOperation.recordFetchedBlock = { (record) in
                guard let name = record["name"] as? String else { return }
                // Receive image
                let imageAsset = record["image"] as? CKAsset
                let imageURL = imageAsset?.fileURL
                items.append(Fruit(name: name, imageURL: imageURL, record: record))
            }
        }

        
        if #available(iOS 15.0, *) {
            queryOperation.queryResultBlock = { [weak self] result in
                print("RETURNED queryResultBlock: \(result)")
                DispatchQueue.main.async {
                    self?.fruits = items
                }
            }
        } else {
            queryOperation.queryCompletionBlock = { [weak self] (cursor, error) in
                print("RETURNED queryCompletionBlock")
                DispatchQueue.main.async {
                    self?.fruits = items
                }
            }
        }

        self.addOperation(operation: queryOperation)
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
 
    func updateitem(fruit: Fruit) {
        let record = fruit.record
        record["name"] = "NEW NAME!!!"
        self.saveItem(record: record)
    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let fruit = self.fruits[index]
        let record = fruit.record
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] recordID, error in
            self?.fruits.remove(at: index)
        }
    }
    
}

struct CloudKitCRUDBootcamp: View {
    
    @StateObject private var vm = CloudKitCRUDBootcampViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                self.header
                self.textField
                self.addButton
                
                List {
                    ForEach(self.vm.fruits, id: \.self) { fruit in
                        HStack {
                            Text(fruit.name)
                            
                            if let url = fruit.imageURL,
                                let data = try? Data(contentsOf: url),
                                let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            
                        }
                        .onTapGesture {
                            self.vm.updateitem(fruit: fruit)
                        }
                    }
                    .onDelete { indexSet in
                        self.vm.deleteItem(indexSet: indexSet)
                    }
                } //: List
                .listStyle(.plain)
                
            } //: VSTACK
            .padding()
            .navigationBarHidden(true)
        } //: NavigationView
        
    }
}

struct CloudKitCRUDBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitCRUDBootcamp()
    }
}

extension CloudKitCRUDBootcamp {
    
    private var header: some View {
        Text("CloudKit CRUD ☁️☁️☁️")
            .font(.headline)
            .underline()
    }
    
    private var textField: some View {
        TextField("Add something here...", text: self.$vm.text)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var addButton: some View {
        
        Button {
            self.vm.addButtonPressed()
        } label: {
            Text("Add")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.pink)
                .cornerRadius(10)
        }
    }
    
}
