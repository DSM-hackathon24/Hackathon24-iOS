import UIKit
import SnapKit
import Then

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
      }
    
    func customTextField(placeholder: String) {
        self.placeholder = placeholder
        self.font = .systemFont(ofSize: 16, weight: .medium)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = IOSAsset.background1.color.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = UIColor.red.cgColor
        self.returnKeyType = UIReturnKeyType.done
        self.layer.shadowRadius = 15
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.leftViewMode = .always
        self.textColor = .black
    }
}
