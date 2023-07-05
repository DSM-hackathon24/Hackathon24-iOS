import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class QuizViewCell1: UICollectionViewCell {
    var onNextButtonTapped: (() -> Void)?
    var disposeBag: DisposeBag = .init()

    static let id = "QuizViewCell1"

    var quizTitleUILabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.text = "정답입니다!"
        $0.textColor = IOSAsset.quizTextColor.color
    }

    var quizUILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.text = "축하해요! 다음문제도 맞추세요!"
        $0.textColor = IOSAsset.quizTextColor.color
    }

    let correctLogo = UIImageView().then {
        $0.image = IOSAsset.correct.image
    }

    let notCorrectLogo = UIImageView().then {
        $0.image = IOSAsset.notCorrect.image
    }

    let nextCell = UIButton(type: .system).then {
        $0.setImage(IOSAsset.arrow.image, for: .normal)
        $0.tintColor = .black
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 20
        self.layer.borderColor = IOSAsset.quizBorder.color.cgColor
        self.contentView.layer.shadow(color: IOSAsset.quizShadow.color, alpha: 0.4, x: 0, y: 0, blur: 20, spread: 0)
        nextCell.rx.tap.bind { [weak self] in
            self?.onNextButtonTapped?()
        }.disposed(by: disposeBag)
        [
            quizTitleUILabel,
            quizUILabel,
            notCorrectLogo,
            correctLogo,
            nextCell
        ].forEach {
            addSubview($0)
        }
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview().inset(10)
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
        notCorrectLogo.snp.makeConstraints {
            $0.top.equalTo(quizUILabel.snp.bottom).offset(38)
            $0.leading.equalToSuperview().inset(45)
        }
        correctLogo.snp.makeConstraints {
            $0.top.equalTo(quizUILabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(45)
        }
        nextCell.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(0)
            $0.trailing.equalToSuperview().inset(24)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
