import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class PasswordView: BaseVC {
    let viewModel = PasswordViewModel()
    var id: String = ""
    var email: String = ""

    private let logoImageView = UIImageView().then {
        $0.image = IOSAsset.logo.image
    }

    private let signupLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.text = "Sign Up"
        $0.textColor = .black
    }

    let passwordTextField = UITextField().then {
        $0.addLeftPadding()
        $0.customTextField(placeholder: "비밀번호")
        $0.isSecureTextEntry = true
    }

    let checkPasswordTextField = UITextField().then {
        $0.addLeftPadding()
        $0.customTextField(placeholder: "비밀번호 확인")
        $0.isSecureTextEntry = true
    }

    let signupButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 15
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = IOSAsset.buttonColor.color
    }
    override func bind() {
        let input = PasswordViewModel.Input(
            idText: id,
            emailText: email,
            passwordText: passwordTextField.rx.text.orEmpty.asDriver(),
            passwordValidText: checkPasswordTextField.rx.text.orEmpty.asDriver(),
            signupButtonDidTap: signupButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.result
            .bind {
                if $0 {
                    self.dismiss(animated: true)
                } else {
                    print("error")
                }
            }.disposed(by: disposeBag)
    }

    override func addView() {
        [
            logoImageView,
            signupLabel,
            passwordTextField,
            checkPasswordTextField,
            signupButton
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

        passwordTextField.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(50)
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        checkPasswordTextField.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(50)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        signupButton.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(55)
            $0.top.equalTo(checkPasswordTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }
    }
}
