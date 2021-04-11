import Foundation
import XCTest

@testable import FruitRepository


final class FruitSourceJsonApiAdapterTests: XCTestCase {
    
    var fsa: IFruitSourceAdapter!
    
    func testInit() {
        fsa = FruitSourceJsonApiAdapter()
        XCTAssertNotNil(fsa)
    }
    
    func testListAllFruitsCompletes() {
        let promiseToComplete = self.expectation(description: "fetch will complete")

        fsa = FruitSourceJsonApiAdapter()
        fsa.listAllFruitsAsDictionaries {
            result in
            switch result {
                case .failure:
                    break;
                case .success:
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testListAllFruitsReturnsResults() {
       let promiseToComplete = self.expectation(description: "fetch will complete")

        fsa = FruitSourceJsonApiAdapter()
        fsa.listAllFruitsAsDictionaries {
            result in
            switch result {
                case .failure:
                    break;
                case .success:
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testListAllFruitsReturnsNoEmptyResults() {
       let promiseToComplete = self.expectation(description: "fetch will complete")

        fsa = FruitSourceJsonApiAdapter()
        fsa.listAllFruitsAsDictionaries {
            result in
            switch result {
                case .failure(_):
                    break;
                case let .success(dictItems):
                    for dictItem in dictItems {
                        if dictItem.isEmpty {
                            // Please no assert spam
                            XCTAssertFalse(dictItem.isEmpty)
                        }
                    }
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 4, handler: nil)
    }
}
