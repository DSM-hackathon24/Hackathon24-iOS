import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class EmailVeiw: BaseVC, UITextFieldDelegate {

    override func viewDidLoad() {
           super.viewDidLoad()
           firstNumberTextField.delegate = self
           secondNumberTextField.delegate = self
           thirdNumberTextField.delegate = self
           fourthNumberTextField.delegate = self
       }
    
    private let signupIconUIImageView = UIImageView().then {
        $0.image = IOSAsset.logo.image
    }

    private let signupLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.text = "Sign Up"
        $0.textColor = .black
    }

    let firstNumberTextField = UITextField().then {
        $0.customTextField(placeholder: "")
        $0.addLeftPadding()
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        $0.textAlignment = .center
        $0.keyboardType = UIKeyboardType.numberPad
        $0.becomeFirstResponder()
    }

    let secondNumberTextField = UITextField().then {
        $0.customTextField(placeholder: "")
        $0.addLeftPadding()
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        $0.textAlignment = .center
        $0.keyboardType = UIKeyboardType.numberPad
    }

    let thirdNumberTextField = UITextField().then {
        $0.customTextField(placeholder: "")
        $0.addLeftPadding()
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        $0.textAlignment = .center
        $0.keyboardType = UIKeyboardType.numberPad
    }

    let fourthNumberTextField = UITextField().then {
        $0.customTextField(placeholder: "")
        $0.addLeftPadding()
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        $0.textAlignment = .center
        $0.keyboardType = UIKeyboardType.numberPad
    }

    let loginUIButton = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = IOSAsset.buttonColor.color
    }

    override func bind() {
        loginUIButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(PasswordView(), animated: true)
            }.disposed(by: disposeBag)
    }

    override func addView() {
        [
            signupIconUIImageView,
            signupLabel,
            firstNumberTextField,
            secondNumberTextField,
            thirdNumberTextField,
            fourthNumberTextField,
            loginUIButton
        ].forEach {view.addSubview($0)}
    }

    override func setLayout() {
        signupIconUIImageView.snp.makeConstraints {
            $0.width.height.equalTo(35)
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalToSuperview().offset(24)

        }

        signupLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalTo(signupIconUIImageView.snp.trailing).offset(5)
        }

        firstNumberTextField.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(48)
            $0.top.equalTo(signupIconUIImageView.snp.bottom).offset(75)
            $0.leading.equalToSuperview().offset(84)
        }

        secondNumberTextField.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(48)
            $0.top.equalTo(signupIconUIImageView.snp.bottom).offset(75)
            $0.leading.equalTo(firstNumberTextField.snp.trailing).offset(15)
        }

        thirdNumberTextField.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(48)
            $0.top.equalTo(signupIconUIImageView.snp.bottom).offset(75)
            $0.leading.equalTo(secondNumberTextField.snp.trailing).offset(15)
        }

        fourthNumberTextField.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(48)
            $0.top.equalTo(signupIconUIImageView.snp.bottom).offset(75)
            $0.leading.equalTo(thirdNumberTextField.snp.trailing).offset(15)
        }

        loginUIButton.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(55)
            $0.bottom.equalToSuperview().inset(54)
            $0.leading.equalToSuperview().offset(24)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            let numericSet = CharacterSet.decimalDigits
            let isNumeric = string.rangeOfCharacter(from: numericSet.inverted) == nil
            let maxLength = 1
            return isNumeric && newText.count <= maxLength
        }
}
