import Foundation

public protocol IFruitSourceAdapter {
    func listAllFruitsAsDictionaries(onComplete: @escaping (Result<[[String:Any]], Error>) -> Void)
}
