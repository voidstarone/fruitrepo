import Foundation

public protocol IFruitFactory {
    func createFruit(type: String, price: Int, weight: Int) -> IFruitDTO
    func createFruit(fromDict: [String:Any]) -> IFruitDTO?
}
