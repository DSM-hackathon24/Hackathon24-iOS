import Foundation
import RxSwift
import RxCocoa

class EmailViewModel: BaseVM {
    private let disposeBag = DisposeBag()
    struct Input {
        let firstNumberText: Driver<String>
        let secondNumberText: Driver<String>
        let thirdNumberText: Driver<String>
        let fourthNumberText: Driver<String>
        let email: String
        let nextButtonDidTap: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
        let disable: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let disable = PublishRelay<Bool>()
        let info = Driver.combineLatest(
            input.firstNumberText,
            input.secondNumberText,
            input.thirdNumberText,
            input.fourthNumberText
        )

        input.nextButtonDidTap.asObservable()
            .withLatestFrom(info)
            .flatMap {
                api.checkEmailCode(input.email, $0+$1+$2+$3)
            }
            .subscribe(onNext: {
                switch $0 {
                case .getOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        info.asObservable()
            .map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty && !$0.3.isEmpty }
            .bind {
                disable.accept($0)
            }.disposed(by: disposeBag)
        return Output(result: result, disable: disable)
    }
}
