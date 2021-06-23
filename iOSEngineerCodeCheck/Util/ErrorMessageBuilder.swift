import Alamofire
import Foundation
import Moya
import UIKit

class ErrorMessageBuilder {
    static func buildErrorMessage(error: Error, message: String) -> String {
        var errorMessage = message
        if let moyaError = error as? MoyaError, let error = ((moyaError.errorUserInfo["NSUnderlyingError"]as? Alamofire.AFError)?.underlyingError as NSError?) {
            switch error.code {
            case -1009: // NSURLErrorNotConnectedToInternet
                errorMessage = message + "(インターネット接続がありません)"
            default:
                errorMessage = message
            }
        }
        return errorMessage
    }
}
