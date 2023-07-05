import Foundation
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

final class Service {

    let provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])

    func login(_ accountId: String, _ password: String) -> Single<NetworkingResult> {
        return provider.rx.request(.login(accountId: accountId, password: password))
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map { response -> NetworkingResult in
                Token.accessToken = response.ark
                Token.refreshToken = response.rtk
                return .getOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func sendEmailCode(_ email: String) -> Single<NetworkingResult> {
        return provider.rx.request(.sendEmailCode(email: email))
            .filterSuccessfulStatusCodes()
            .map { _ -> NetworkingResult in
                return .deleteOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func checkEmailCode(_ email: String, _ code: String) -> Single<NetworkingResult> {
        return provider.rx.request(.checkEmailCode(email: email, code: code))
            .filterSuccessfulStatusCodes()
            .map { _ -> NetworkingResult in
                return .getOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func signup(_ email: String, _ id: String,
                _ password: String, _ passwordValid: String) -> Single<NetworkingResult> {
        return provider.rx
            .request(.signup(email: email, accountId: id, password: password, passwordValid: passwordValid))
            .filterSuccessfulStatusCodes()
            .map { _ -> NetworkingResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func setNetworkError(_ error: Error) -> NetworkingResult {
            print(error)
            print(error.localizedDescription)
            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
            return (NetworkingResult(rawValue: status) ?? .fault)
    }
}
