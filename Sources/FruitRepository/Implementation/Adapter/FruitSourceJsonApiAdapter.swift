import Foundation

internal struct FruitSourceJsonApiAdapterConfig {
    public let apiUrl: URL
}

enum FruitSourceJsonApiAdapterError : Error {
    case noData
    case invalidData
    case noConnection
    case badKey
    case badPath
    case badRequest
    case serverError
    case timeout
}

public struct FruitSourceJsonApiAdapter : IFruitSourceAdapter {
    
    var config: FruitSourceJsonApiAdapterConfig = FruitSourceJsonApiAdapterConfig(apiUrl: URL(string:"https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json")!)
    
    init() {}
    
    init(config: FruitSourceJsonApiAdapterConfig) {
        self.config = config
    }
    
    private func lookUpError(byStatusCode statusCode: Int) -> FruitSourceJsonApiAdapterError? {
        switch statusCode {
        case 401:
            // Ideally we'd have something in here to log the error messages, but omitted due to time.
            return FruitSourceJsonApiAdapterError.badKey
        case 404:
            return FruitSourceJsonApiAdapterError.badPath
        case 408:
            return FruitSourceJsonApiAdapterError.timeout
        case 422:
            return FruitSourceJsonApiAdapterError.badRequest
        case 500...599:
            return FruitSourceJsonApiAdapterError.serverError
        default:
            break
        }
        return nil
    }
    
    public func listAllFruitsAsDictionaries(onComplete: @escaping (Result<[[String:Any]], Error>) -> Void) {
        let apiUrl = config.apiUrl
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Ideally this would be abstracted so we could mock no connection
        // Which would also allow us to fully cover lookUpError
        // I am aware there is a fully mocked version of this just ready to
        // go up on GitHub, but there's no version that works with my machine.
        // On every single commit, either the Swift version is too low, or
        // the swift-tools version is to high.
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            data, response, requestError in
            do {
                if requestError != nil {
                    onComplete(.failure(FruitSourceJsonApiAdapterError.timeout))
                    return
                }
                // If this cast fails I have bigger problems than I can handle
                let statusCode = (response as! HTTPURLResponse).statusCode
                if let error = self.lookUpError(byStatusCode: statusCode) {
                    onComplete(.failure(error))
                    return
                }
                
                if data == nil {
                    onComplete(.failure(FruitSourceJsonApiAdapterError.noData))
                    return
                }
                print( String(decoding: data!, as: UTF8.self))
                guard let rawDict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: [[String: Any]]] else {
                    onComplete(.failure(FruitSourceJsonApiAdapterError.invalidData))
                    return
                }
                
                guard let dicts = rawDict["fruit"] else {
                    onComplete(.failure(FruitSourceJsonApiAdapterError.invalidData))
                    return
                }
                onComplete(.success(dicts))
            } catch {
                onComplete(.failure(error))
            }
            
        }
        task.resume()
    }
}
