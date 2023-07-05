import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class QuizViewCell: UICollectionViewCell {

    var onAnswerSelected: (() -> Void)?
    var onNotAnswerSelected: (() -> Void)?
    var disposeBag: DisposeBag = .init()
    static let id = "QuizViewCell"

    var quizTitleUILabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.text = "소화전 근처에는 자동차를\n주차해도 되나요?"
        $0.textColor = IOSAsset.quizTextColor.color
    }

    var quizUILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.text = "O / X 선택해주세요!"
        $0.textColor = IOSAsset.quizTextColor.color
    }

    let quizLogo = UIImageView().then {
        $0.image = IOSAsset.quizLogo.image
    }

    let quizisYes = UIButton(type: .system).then {
        $0.setImage(IOSAsset.quizYes.image, for: .normal)
        $0.tintColor = .green
    }
    let quizisNo = UIButton(type: .system).then {
        $0.setImage(IOSAsset.quizNo.image, for: .normal)
        $0.tintColor = .red
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        quizisYes.rx.tap.bind { [weak self] in
            self?.onAnswerSelected?()
                }.disposed(by: disposeBag)
        quizisNo.rx.tap.bind { [weak self] in
            self?.onNotAnswerSelected?()
        }.disposed(by: disposeBag)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = IOSAsset.quizBorder.color.cgColor
        self.layer.cornerRadius = 20
        self.layer.shadow(color: IOSAsset.quizShadow.color, alpha: 0.4, x: 0, y: 0, blur: 20, spread: 0)
        [
            quizTitleUILabel,
            quizUILabel,
            quizLogo,
            quizisNo,
            quizisYes
        ].forEach {
            addSubview($0)
        }

        quizTitleUILabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalToSuperview().offset(25)
        }
        quizUILabel.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(quizTitleUILabel.snp.bottom).offset(6)
        }
        quizLogo.snp.makeConstraints {
            $0.height.width.equalTo(230)
            $0.top.equalTo(quizUILabel.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(38)
        }
        quizisNo.snp.makeConstraints {
            $0.height.width.equalTo(50)
            $0.top.equalTo(quizLogo.snp.bottom).offset(70)
            $0.leading.equalToSuperview().inset(24)
        }
        quizisYes.snp.makeConstraints {
            $0.height.width.equalTo(60)
            $0.top.equalTo(quizLogo.snp.bottom).offset(70)
            $0.trailing.equalToSuperview().inset(24)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
