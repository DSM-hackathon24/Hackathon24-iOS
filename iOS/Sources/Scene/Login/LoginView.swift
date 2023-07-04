import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class LoginView: BaseVC {
    let viewModel = LoginViewModel()

    private let logoImageView = UIImageView().then {
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

    let loginButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 15
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = IOSAsset.buttonColor.color
    }

    let questionLabel = UILabel().then {
        $0.text = "아직 회원이 아니신가요?"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = .clear
    }

    let signUpButton = UIButton(type: .system).then {
        $0.setTitleColor( IOSAsset.signupUIButtonColor.color, for: .normal)
        $0.setTitle("회원가입하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = .clear
        $0.setUnderline()
    }
    override func bind() {
        let input = LoginViewModel.Input(
            idText: idTextField.rx.text.orEmpty.asDriver(),
            passwordText: passwordTextField.rx.text.orEmpty.asDriver(),
            loginButtonDidTap: loginButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                self.dismiss(animated: true)
                print("성공")
            case false:
                print("실패")
            }
        }).disposed(by: disposeBag)
        signUpButton.rx.tap
            .bind {
                let signupView = BaseNC(rootViewController: SignupView())
                signupView.modalPresentationStyle = .fullScreen
                self.present(signupView, animated: true)
            }.disposed(by: disposeBag)
    }

    override func addView() {
        [
            logoImageView,
            loginLabel,
            idTextField,
            passwordTextField,
            loginButton,
            questionLabel,
            signUpButton
        ].forEach {view.addSubview($0)}
    }

    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.width.height.equalTo(35)
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalToSuperview().offset(24)

        }

        loginLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(5)
        }

        idTextField.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(50)
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        passwordTextField.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(50)
            $0.top.equalTo(idTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        loginButton.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(55)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        questionLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(94)
        }

        signUpButton.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalTo(questionLabel.snp.trailing).offset(2)
        }
    }
}
