import RxSwift
import RxCocoa
import UIKit
import SnapKit
import Then

class QuizView: BaseVC {
    fileprivate var comp = 0
    private let quizUILabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.text = "소방 안전 Quiz"
    }

    private lazy var quizCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.register(QuizViewCell.self, forCellWithReuseIdentifier: QuizViewCell.id)
        collectionView.register(QuizViewCell1.self, forCellWithReuseIdentifier: QuizViewCell1.id)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        quizCollectionView.delegate = self
        quizCollectionView.dataSource = self
        view.backgroundColor = IOSAsset.quizBackground.color
    }

    override func addView() {
        [
            quizUILabel,
            quizCollectionView
        ].forEach {view.addSubview($0)}
    }

    override func setLayout() {
        quizUILabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(110)
            $0.leading.equalToSuperview().offset(54.0)
        }
        quizCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(174)
            $0.leading.equalToSuperview().inset(44)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(120)
        }
    }
}

extension QuizView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 305, height: 538)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension QuizView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if ((indexPath.row + 1) % 2 != 0) {
            if let quizViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: QuizViewCell.id,
                for: indexPath) as? QuizViewCell {
                quizViewCell.onAnswerSelected = { [weak self] in
                    self?.comp = 1
                    self?.quizCollectionView.scrollToItem(at: IndexPath(row: (indexPath.row + 1), section: 0),
                                                          at: .left, animated: true)
                }
                quizViewCell.onNotAnswerSelected = { [weak self] in
                    self?.comp = 0
                    self?.quizCollectionView.scrollToItem(at: IndexPath(row: (indexPath.row + 1), section: 0),
                                                          at: .left, animated: true)
                }
                switch indexPath.row {
                case 0:
                    quizViewCell.quizTitleUILabel.text = "소화전 근처에는 자동차를\n주차해도 되나요?"
                    return quizViewCell
                case 2:
                    quizViewCell.quizTitleUILabel.text = "소화기의 유통기한은\n제조 일자로부터 10년이다?"
                    return quizViewCell
                case 4:
                    quizViewCell.quizTitleUILabel.text = "소화기는 의무 설치가 아닌\n권장 설치이다."
                    return quizViewCell
                default:
                    return quizViewCell
                }
            } else {
                fatalError("Unable to dequeue quizViewCell")
            }
        } else {
            if let quizViewCell1 = collectionView.dequeueReusableCell(
                withReuseIdentifier: QuizViewCell1.id,
                for: indexPath) as? QuizViewCell1 {
                quizViewCell1.onNextButtonTapped = { [weak self] in
                    self?.quizCollectionView.scrollToItem(at: IndexPath(row: (indexPath.row + 1), section: 0),
                                                          at: .left, animated: true)
                }
                if indexPath.row == 1 && comp == 1 {
                    quizViewCell1.quizTitleUILabel.text = "오답입니다."
                    quizViewCell1.quizUILabel.text = "아쉬워요! 다음문제 도전해보세요!"
                    quizViewCell1.correctLogo.isHidden = true
                    quizViewCell1.notCorrectLogo.isHidden = false
                    return quizViewCell1
                } else if  indexPath.row == 1 && comp == 0 {
                    quizViewCell1.quizTitleUILabel.text = "정답입니다."
                    quizViewCell1.quizUILabel.text = "축하해요! 다음문제도 맞춰보세요!"
                    quizViewCell1.correctLogo.isHidden = false
                    quizViewCell1.notCorrectLogo.isHidden = true
                    return quizViewCell1
                } else if indexPath.row == 3 && comp == 1 {
                    quizViewCell1.quizTitleUILabel.text = "정답입니다."
                    quizViewCell1.quizUILabel.text = "축하해요! 다음문제도 맞춰보세요!"
                    quizViewCell1.correctLogo.isHidden = false
                    quizViewCell1.notCorrectLogo.isHidden = true
                    return quizViewCell1
                } else if indexPath.row == 3 && comp == 0 {
                    quizViewCell1.quizTitleUILabel.text = "오답입니다."
                    quizViewCell1.quizUILabel.text = "아쉬워요! 다음문제 도전해보세요!"
                    quizViewCell1.correctLogo.isHidden = true
                    quizViewCell1.notCorrectLogo.isHidden = false
                    return quizViewCell1
                } else if indexPath.row == 5 && comp == 0 {
                    quizViewCell1.quizTitleUILabel.text = "정답입니다."
                    quizViewCell1.quizUILabel.text = "소방 안전 Quiz에 참여해 주셔서 감사합니다!"
                    quizViewCell1.correctLogo.isHidden = true
                    quizViewCell1.notCorrectLogo.isHidden = true
                    quizViewCell1.correctLogo.isHidden = false
                    quizViewCell1.nextCell.isHidden = true
                    return quizViewCell1
                } else {
                    quizViewCell1.quizTitleUILabel.text = "오답입니다."
                    quizViewCell1.quizUILabel.text = "소방 안전 Quiz에 참여해 주셔서 감사합니다!"
                    quizViewCell1.correctLogo.isHidden = true
                    quizViewCell1.notCorrectLogo.isHidden = false
                    quizViewCell1.correctLogo.isHidden = true
                    quizViewCell1.nextCell.isHidden = true
                    return quizViewCell1
                }
            } else {
                fatalError("Unable to dequeue quizViewCell1")
            }
        }
    }
}
