import Foundation

public protocol IFruitRepo {
    
    init(fruitSourceAdapter: IFruitSourceAdapter)
    init(fruitFactory: IFruitFactory, fruitSourceAdapter: IFruitSourceAdapter)
    
    func listAllFruits(onComplete: @escaping (Result<[IFruitDTO], Error>) -> Void)
}
