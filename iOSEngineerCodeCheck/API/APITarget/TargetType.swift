import Foundation
import Moya

protocol ApiTargetType: TargetType {
    // レスポンスの型を定義できるようにする
    associatedtype Response: Codable
}

extension ApiTargetType {
    //swiftlint:disable:next force_unwrapping
    var baseURL: URL { URL(string: "https://api.github.com")! }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
}
