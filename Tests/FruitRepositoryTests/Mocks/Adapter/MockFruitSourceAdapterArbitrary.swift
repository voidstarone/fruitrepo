import Foundation
@testable import FruitRepository

struct MockFruitSourceAdapterArbitrary : IFruitSourceAdapter {
    
    var fruitFactory: IFruitFactory = FruitFactory()
    var fruitsToSupply: [[String:String]] = [
        ["type":"apple", "price":"149", "weight":"120"],
        ["type":"banana", "price":"129", "weight":"80"]
    ];
    
    func listAllFruitsAsDictionaries(onComplete: @escaping (Result<[[String:Any]], Error>) -> Void) {
        
        let fruitsToReturn = fruitsToSupply
        
        onComplete(.success(fruitsToReturn))
    }
}
