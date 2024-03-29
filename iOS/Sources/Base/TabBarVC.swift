import UIKit
import RxSwift
import RxCocoa
import RxFlow

class TabBarVC: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTabBarLayout()
        setUpTabBarItem()
        if Token.accessToken == nil {
            let loginView = BaseNC(rootViewController: LoginView())
            loginView.modalPresentationStyle = .fullScreen
            self.present(loginView, animated: true)
        }
    }
    override func viewDidLoad() {
        Token.accessToken = nil
    }

    func setUpTabBarLayout() {
        let tabBar: UITabBar = self.tabBar
        tabBar.barTintColor = IOSAsset.background1.color
        tabBar.unselectedItemTintColor = IOSAsset.backGround5.color
        tabBar.tintColor = IOSAsset.backGround7.color
        tabBar.backgroundColor = .white
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowColor = IOSAsset.shadowColor.color.cgColor
        tabBar.layer.shadowRadius = 15
        tabBar.itemSpacing = 50
        self.hidesBottomBarWhenPushed = true
    }

    func setUpTabBarItem() {
        let quizView = QuizView()
        quizView.tabBarItem = UITabBarItem(
            title: "Quiz",
            image: IOSAsset.quiz.image,
            selectedImage: IOSAsset.quiz.image
        )
        let mapView = MapView()
        mapView.tabBarItem = UITabBarItem(
            title: "소화전 지도",
            image: IOSAsset.map.image,
            selectedImage: IOSAsset.map.image
        )
        let feedView = FeedView()
        feedView.tabBarItem = UITabBarItem(
            title: "커뮤니티",
            image: IOSAsset.feed.image,
            selectedImage: IOSAsset.feed.image
        )
        viewControllers = [
            quizView,
            mapView,
            feedView
        ]
    }
}
