import Foundation
import XCTest

@testable import FruitRepository


final class FruitRepoTests: XCTestCase {
    
    var ep: IFruitRepo!
    
    override func setUp() {
        ep = FruitRepo(fruitFactory: MockFruitFactory(), fruitSourceAdapter: MockFruitSourceAdapterSuccessful())
    }
    
    func testInit() {
        XCTAssertNotNil(ep)
    }
    
    func testListAllFruitsCompletes() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        
        ep.listAllFruits {
            result in
            switch result {
            case .failure:
                break;
            case .success:
                promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListAllFruitsFailsGracefully() {
        let promiseToComplete = self.expectation(description: "fetch will fail due to bad data")
        
        ep = FruitRepo(fruitFactory: MockFruitFactoryFails(),
                       fruitSourceAdapter: MockFruitSourceAdapterFailure())
        
        ep.listAllFruits {
            result in
            switch result {
            case .failure:
                promiseToComplete.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListAllFruitsReturnsResults() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        
        ep.listAllFruits {
            result in
            switch result {
            case .failure:
                break;
            case let .success(fruits):
                XCTAssertGreaterThan(fruits.count, 0)
                let fruit: IFruitDTO = fruits[0]
                XCTAssertNotNil(fruit)
                promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
