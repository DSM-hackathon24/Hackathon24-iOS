import Foundation
import UIKit
import Moya

enum API {
    case login(accountId: String, password: String)
    case sendEmailCode(email: String)
    case checkEmailCode(email: String, code: String)
    case signup(email: String, accountId: String, password: String, passwordValid: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://172.30.65.10:8080")!
    }

    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .sendEmailCode:
            return "/user/code"
        case .checkEmailCode:
            return "/user/check"
        case .signup:
            return "/user/signup"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .sendEmailCode, .checkEmailCode, .signup:
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
        case .sendEmailCode(let email):
            return .requestParameters(parameters:
                                        [
                                            "email": email
                                        ], encoding: JSONEncoding.default)
        case .checkEmailCode(let email, let code):
            return .requestParameters(parameters:
                                        [
                                            "code": code,
                                            "email": email
                                        ], encoding: JSONEncoding.default)
        case .signup(let email, let accountId, let password, let passwordValid):
            return .requestParameters(parameters:
                                        [
                                            "email": email,
                                            "accountId": accountId,
                                            "password": password,
                                            "passwordValid": passwordValid
                                        ], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login, .sendEmailCode, .checkEmailCode, .signup:
            return Header.tokenIsEmpty.header()
        }
    }
}
