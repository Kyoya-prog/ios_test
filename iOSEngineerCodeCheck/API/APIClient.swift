import Foundation
import Moya

protocol APIClientInterface {
    func send<T: ApiTargetType>(_ request: T, completion: @escaping (Result<T.Response, Moya.MoyaError>) -> Void)
}

class APIClient: APIClientInterface {
    func send<T>(_ request: T, completion: @escaping (Result<T.Response, MoyaError>) -> Void) where T: ApiTargetType {
        let provider = MoyaProvider<T>()
        provider.request(request) { result in
            switch result {
            case let .success(response):

                let decoder = JSONDecoder()
                if let model = try? decoder.decode(T.Response.self, from: response.data) {
                    completion(.success(model))
                } else {
                    completion(.failure(.jsonMapping(response)))
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
