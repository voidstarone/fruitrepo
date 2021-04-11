import Foundation
@testable import FruitRepository

public struct MockFruitFactoryFails : IFruitFactory {
    
    public func createFruit(fromDict fruitDict: [String : Any]) -> IFruitDTO? {
        return nil
    }
    
    public func createFruit(type: String, price: Int, weight: Int) -> IFruitDTO {
        return MockFruit(type: "hummus",
                         pencePrice: 10,
                         gramsWeight: 30)
    }
}
