import Foundation

import RxSwift
import RxCocoa

class PasswordViewModel: BaseVM {

    struct Input {
        let idText: String
        let emailText: String
        let passwordText: Driver<String>
        let passwordValidText: Driver<String>
        let signupButtonDidTap: Signal<Void>
    }

    struct Output {
        let result: PublishRelay<Bool>
        let disable: PublishRelay<Bool>
    }

    private var disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.passwordText, input.passwordValidText)
        let result = PublishRelay<Bool>()
        let disable = PublishRelay<Bool>()
        input.signupButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap { password, passwordValid in
                api.signup(input.emailText, input.idText, password, passwordValid)
            }.subscribe(onNext: { res in
                switch res {
                case .createOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        info.asObservable()
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .bind {
                disable.accept($0)
            }.disposed(by: disposeBag)
        return Output(result: result, disable: disable)
    }
}
