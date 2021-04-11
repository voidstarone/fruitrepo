import XCTest
@testable import FruitRepository

final class FruitRepositoryTests: XCTestCase {
    
    func testListAll() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        let fr = FruitRepo.default
        
        fr.listAllFruits {
            result in
            
            switch result {
            case .failure:
                break
            case let .success(fruits):
                if fruits.count > 0 {
                    promiseToComplete.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 25080, handler: nil)
    }
    
    
    static var allTests = [
        ("testListAll", testListAll)
    ]
}
