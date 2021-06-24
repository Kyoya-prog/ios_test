import Foundation
import Moya

protocol APIClientInterface {
    func send<T: ApiTargetType>(_ request: T, completion: @escaping (Result<T.Response, Moya.MoyaError>) -> Void)
}

/// 指定したTargetTypeでリクエストができるAPIClientラッパークラス
class APIClient: APIClientInterface {
    func send<T>(_ request: T, completion: @escaping (Result<T.Response, MoyaError>) -> Void) where T: ApiTargetType {
        // 引数に指定されたTargetType型でMoyaProviderを作成し、
        //その型を使ってAPI通信できるようにする
        let provider = MoyaProvider<T>()
        provider.request(request) { result in
            switch result {
            case let .success(response):
                // リクエストが成功した際はレスポンスのjsonをデコードする
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(T.Response.self, from: response.data) {
                    // デコードに成功した
                    completion(.success(model))
                } else {
                    // デコードに失敗した
                    completion(.failure(.jsonMapping(response)))
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
