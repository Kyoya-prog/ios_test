import Alamofire
import Foundation
import Moya
import UIKit

class ErrorMessageBuilder {
    static func buildErrorMessage(error: Error, message: String) -> String {
        var errorMessage = message
        // NSError型を得るためMoyaErrorの中のNSUnderlyingErrorを抽出し、NSErrorにキャスト
        if let moyaError = error as? MoyaError, let error = ((moyaError.errorUserInfo["NSUnderlyingError"]as? Alamofire.AFError)?.underlyingError as NSError?) {
            switch error.code {
            case -1009: // NSURLErrorNotConnectedToInternet　（ネットワーク接続エラーの場合は、その趣旨をエラーメッセージの後につける）
                errorMessage = message + "(インターネット接続がありません)"
            default:
                errorMessage = message
            }
        }
        return errorMessage
    }
}
