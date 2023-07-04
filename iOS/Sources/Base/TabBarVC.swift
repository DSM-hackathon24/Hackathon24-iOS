import UIKit
import RxSwift
import RxCocoa
import RxFlow

class TabBarVC: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTabBarLayout()
        setUpTabBarItem()
    }

    func setUpTabBarLayout() {
        let tabBar: UITabBar = self.tabBar
        tabBar.barTintColor = UIColor(named: "BackGroundColor")
        tabBar.unselectedItemTintColor = UIColor(named: "Description")
        tabBar.tintColor = UIColor(named: "TextColor")
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.layer.cornerRadius = 20
        self.hidesBottomBarWhenPushed = true
    }

    func setUpTabBarItem() {
        let mainVc = MainVC()
        mainVc.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Calendar"),
            selectedImage: UIImage(named: "Calendar_fill")
        )
        viewControllers = [
            mainVc
        ]
    }
}
