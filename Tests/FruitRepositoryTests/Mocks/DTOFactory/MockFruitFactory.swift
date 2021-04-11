import Foundation
@testable import FruitRepository

public struct MockFruitFactory : IFruitFactory {
    
    public func createFruit(fromDict fruitDict: [String : Any]) -> IFruitDTO? {
        return MockFruit(type: "lemon", pencePrice: 45, gramsWeight: 16)
    }
    
    public func createFruit(type: String, price pencePrice: Int, weight gramsWeight: Int) -> IFruitDTO {
        return MockFruit(type: "lemon", pencePrice: 45, gramsWeight: 16)
    }
}
