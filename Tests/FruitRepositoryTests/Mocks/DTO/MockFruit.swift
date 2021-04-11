import Foundation
@testable import FruitRepository

struct MockFruit : IFruitDTO {
    var type: String
    var pencePrice: Int
    var gramsWeight: Int
}
