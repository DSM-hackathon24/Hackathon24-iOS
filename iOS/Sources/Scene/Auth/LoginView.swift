//
//  LoginView.swift
//  iOS
//
//  Created by 박주영 on 2023/07/04.
//  Copyright © 2023 com.Hackathon24. All rights reserved.
//

import UIKit
import Then
import SnapKit

class LoginView: BaseVC {

    private let loginPageIcon = UIImageView().then {
        $0.image = IOSAsset.logo.image
    }

    private let loginText = UILabel().then {
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
    
    let loginButton = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = IOSAsset.buttonColor.color
    }
    
    let signUpQuestion = UILabel().then {
        $0.text = "아직 회원이 아니신가요?"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = .clear
    }
    
    let signUpText = UIButton().then {
        $0.setTitleColor( IOSAsset.color1.color, for: .normal)
        $0.setTitle("회원가입하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = .clear
        $0.setUnderline()
    }

    override func addView() {
        [
            loginPageIcon,
            loginText,
            idTextField,
            passwordTextField,
            loginButton,
            signUpQuestion,
            signUpText
        ].forEach {view.addSubview($0)}
    }

    override func setLayout() {
        loginPageIcon.snp.makeConstraints {
            $0.width.height.equalTo(35)
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalToSuperview().offset(24)

        }

        loginText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalTo(loginPageIcon.snp.trailing).offset(5)
        }

        idTextField.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(50)
            $0.top.equalTo(loginPageIcon.snp.bottom).offset(16)
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
        
        signUpQuestion.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(94)
        }
        
        signUpText.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalTo(signUpQuestion.snp.trailing).offset(2)
        }
    }
}

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
