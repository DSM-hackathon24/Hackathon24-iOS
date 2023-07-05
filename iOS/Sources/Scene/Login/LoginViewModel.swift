import Foundation

import RxSwift
import RxCocoa

class LoginViewModel: BaseVM {

    struct Input {
        let idText: Driver<String>
        let passwordText: Driver<String>
        let loginButtonDidTap: Signal<Void>
    }

    struct Output {
        let result: PublishRelay<Bool>
        let disable: PublishRelay<Bool>
    }

    private var disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.idText, input.passwordText)
        let result = PublishRelay<Bool>()
        let disable = PublishRelay<Bool>()
        input.loginButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap {id, password in
                api.login(id, password)
            }.subscribe(onNext: { res in
                switch res {
                case .getOk:
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
