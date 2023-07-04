import Foundation
import UIKit
import Moya

enum API {
    case login(accountId: String, password: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://172.30.65.10:8080")!
    }

    var path: String {
        switch self {
        case .login:
            return "/user/login"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .login(let accountId, let password):
            return .requestParameters(parameters:
                                        [
                                            "accountId": accountId,
                                            "password": password
                                        ], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login:
            return Header.tokenIsEmpty.header()
        }
    }
}
