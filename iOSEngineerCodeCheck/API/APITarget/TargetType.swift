import Foundation
import Moya

// GitHubAPIService.swift
protocol GitHubAPITargetType: TargetType {
    // レスポンスの型を定義できるように変更
    // 追加
    associatedtype Response: Codable
}

extension GitHubAPITargetType {
    //swiftlint:disable:next force_unwrapping
    var baseURL: URL { URL(string: "https://api.github.com")! }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
}


