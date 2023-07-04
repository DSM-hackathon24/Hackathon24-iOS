import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class SignupView: BaseVC {

    private let logoImageView = UIImageView().then {
        $0.image = IOSAsset.logo.image
    }

    private let signupLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.text = "Sign Up"
        $0.textColor = .black
    }

    let idTextField = UITextField().then {
        $0.customTextField(placeholder: "아이디를 입력해 주세요")
        $0.addLeftPadding()
    }

    let emailTextField = UITextField().then {
        $0.addLeftPadding()
        $0.customTextField(placeholder: "이메일을 입력해 주세요")
    }

    let nextButton = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = IOSAsset.buttonColor.color
    }

    override func bind() {
        nextButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(EmailVeiw(), animated: true)
            }.disposed(by: disposeBag)
    }

    override func addView() {
        [
            logoImageView,
            signupLabel,
            idTextField,
            emailTextField,
            nextButton
        ].forEach {view.addSubview($0)}
    }

    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.width.height.equalTo(35)
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalToSuperview().offset(24)

        }

        signupLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(5)
        }

        idTextField.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(50)
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        emailTextField.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(50)
            $0.top.equalTo(idTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        nextButton.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(55)
            $0.top.equalTo(emailTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }
    }
}
