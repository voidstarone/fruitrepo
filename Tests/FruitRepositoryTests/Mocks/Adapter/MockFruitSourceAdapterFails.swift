import Foundation
@testable import FruitRepository


enum MockError : Error {
    case mock
}

struct MockFruitSourceAdapterFailure : IFruitSourceAdapter {
    var fruitFactory: IFruitFactory = FruitFactory()
    
    init() {}
    
    func listAllFruitsAsDictionaries(onComplete: @escaping (Result<[[String:Any]], Error>) -> Void) {
        onComplete(.failure(MockError.mock))
    }
}
