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
    func setNetworkError(_ error: Error) -> NetworkingResult {
            print(error)
            print(error.localizedDescription)
            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
            return (NetworkingResult(rawValue: status) ?? .fault)
    }
}
