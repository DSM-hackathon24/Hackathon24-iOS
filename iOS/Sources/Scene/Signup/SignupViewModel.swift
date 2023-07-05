import Foundation

import RxSwift
import RxCocoa

class SignupViewModel: BaseVM {

    struct Input {
        let idText: Driver<String>
        let emailText: Driver<String>
        let nextButtonDidTap: Signal<Void>
    }

    struct Output {
        let result: PublishRelay<Bool>
        let disable: PublishRelay<Bool>
    }

    private var disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.idText, input.emailText)
        let result = PublishRelay<Bool>()
        let disable = PublishRelay<Bool>()
        input.nextButtonDidTap
            .asObservable()
            .withLatestFrom(input.emailText)
            .flatMap { email in
                api.sendEmailCode(email)
            }.subscribe(onNext: { res in
                switch res {
                case .deleteOk:
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
