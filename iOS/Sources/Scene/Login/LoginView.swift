import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class LoginView: BaseVC {

    private let loginIconUIImageView = UIImageView().then {
        $0.image = IOSAsset.logo.image
    }

    private let loginLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.text = "Login"
        $0.textColor = .black
    }

    let idTextField = UITextField().then {
        $0.customTextField(placeholder: "아이디를 입력해 주세요")
        $0.addLeftPadding()
    }

    let passwordTextField = UITextField().then {
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
        $0.customTextField(placeholder: "비밀번호를 입력해 주세요")
    }

    let loginUIButton = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = IOSAsset.buttonColor.color
    }

    let signUpQuestionLabel = UILabel().then {
        $0.text = "아직 회원이 아니신가요?"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = .clear
    }

    let signUpUIButton = UIButton().then {
        $0.setTitleColor( IOSAsset.signupUIButtonColor.color, for: .normal)
        $0.setTitle("회원가입하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = .clear
        $0.setUnderline()
    }
    override func bind() {
        signUpUIButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(SignupView(), animated: true)
            }.disposed(by: disposeBag)
    }

    override func addView() {
        [
            loginIconUIImageView,
            loginLabel,
            idTextField,
            passwordTextField,
            loginUIButton,
            signUpQuestionLabel,
            signUpUIButton
        ].forEach {view.addSubview($0)}
    }

    override func setLayout() {
        loginIconUIImageView.snp.makeConstraints {
            $0.width.height.equalTo(35)
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalToSuperview().offset(24)

        }

        loginLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalTo(loginIconUIImageView.snp.trailing).offset(5)
        }

        idTextField.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(50)
            $0.top.equalTo(loginIconUIImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        passwordTextField.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(50)
            $0.top.equalTo(idTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        loginUIButton.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(55)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        signUpQuestionLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(loginUIButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(94)
        }

        signUpUIButton.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(loginUIButton.snp.bottom).offset(20)
            $0.leading.equalTo(signUpQuestionLabel.snp.trailing).offset(2)
        }
    }
}
