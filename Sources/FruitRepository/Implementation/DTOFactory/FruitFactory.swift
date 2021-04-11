import Foundation

internal struct FruitFactory : IFruitFactory {
    
    func createFruit(type: String, price: Int, weight: Int) -> IFruitDTO {
        return Fruit(type: type,
                     pencePrice: price,
                     gramsWeight: weight)
    }
    
    func createFruit(fromDict fruitDict:[String:Any]) -> IFruitDTO? {
        guard let type = fruitDict["type"] as? String else {
            return nil
        }
        guard let price = fruitDict["price"] as? Int else {
            return nil
        }
        guard let weight = fruitDict["weight"] as? Int else {
            return nil
        }
        
        return createFruit(type: type, price: price, weight: weight)
    }
}
