import Foundation
@testable import FruitRepository

struct MockFruitSourceAdapterSuccessful : IFruitSourceAdapter {
    var fruitFactory: IFruitFactory = MockFruitFactory()
    
    init() {}

    func listAllFruitsAsDictionaries(onComplete: @escaping (Result<[[String:Any]], Error>) -> Void) {
        let fruits: [[String:Any]] = [
            ["type":"apple", "price":149, "weight":120],
            ["type":"banana", "price":129, "weight":80]
        ]
        onComplete(.success(fruits))
    }
}
