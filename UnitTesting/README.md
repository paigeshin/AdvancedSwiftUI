#  Unit Test 

- Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
- Naming Structure: test_[struct or class]_[variable or function]_[expected result]
- Testing Structure: Given, When, Then 

### Combine Testing 

```swift
final class NewMockDataService_Tests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.cancellables.removeAll()
    }

    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        // Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [
            UUID().uuidString,
            UUID().uuidString,
            UUID().uuidString,
        ]
        
        // When
        let dataService = NewMockDataService(items: items)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        // Then
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
        
    }
    
    func test_NewMockDataService_downloadItemsWithEscaping_doesReturnValues() {
        // Given
        let dataService = NewMockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService
            .downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)

        
//        dataService.downloadItemsWithEsacping { returnedItems in
//            items = returnedItems
//            expectation.fulfill()
//        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
    }

    func test_NewMockDataService_downloadItemsWithEscaping_doesFail() {
        // Given
        let dataService = NewMockDataService(items: [])
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw URLError.badServerResponse")
        
        dataService
            .downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    expectation.fulfill()
                    
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    if urlError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                    
                case .finished:
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &self.cancellables)


        // Then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
    }

    
}

```
