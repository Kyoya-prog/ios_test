import Foundation
import Moya

struct SearchRepositoryTarget: ApiTargetType {
    typealias Response = Repositories

    let keyword: String

    var method: Moya.Method = .get

    var path: String { "/search/repositories" }

    var sampleData: Data {
        Data()
    }

    var task: Task { .requestParameters(parameters: ["q": keyword], encoding: URLEncoding.default) }
}
