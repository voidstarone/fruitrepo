import Foundation

public enum FruitRepoError : Error {
    case network
    case unknown
}

public struct FruitRepo : IFruitRepo {
    
    private let fruitSourceAdapter: IFruitSourceAdapter
    private let fruitFactory: IFruitFactory = FruitFactory()
    
    public static let `default` = FruitRepo(fruitSourceAdapter:
        FruitSourceJsonApiAdapter(config: FruitSourceJsonApiAdapterConfig(apiUrl: URL(string:"https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json")!)))
    
    public init(fruitFactory: IFruitFactory, fruitSourceAdapter: IFruitSourceAdapter) {
        self.fruitSourceAdapter = fruitSourceAdapter
    }
    
    public init(fruitSourceAdapter: IFruitSourceAdapter) {
        self.fruitSourceAdapter = fruitSourceAdapter
    }
    
    private func produceFruitRepoError(from inError: FruitSourceJsonApiAdapterError) -> FruitRepoError {
        switch inError {
        case .timeout:
            return .network
        default:
            return .unknown
        }
    }

    public func listAllFruits(onComplete: @escaping (Result<[IFruitDTO], Error>) -> Void) {
        fruitSourceAdapter.listAllFruitsAsDictionaries {
            result in
            
            switch result {
            case let .failure(error as FruitSourceJsonApiAdapterError):
                onComplete(.failure(self.produceFruitRepoError(from: error)))
                break
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(dictFruits):
                var fruits: [IFruitDTO] = []
                for dictFruit in dictFruits {
                    guard let fruit = self.fruitFactory.createFruit(fromDict: dictFruit) else {
                        continue
                    }
                    fruits.append(fruit)
                }
                onComplete(.success(fruits))
            }
        }
    }
    
}
