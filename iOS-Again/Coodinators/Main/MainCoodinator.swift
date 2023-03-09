import UIKit

class MainCoodinator: Coodinator {
    var childCoodinators: [Coodinator] = []
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MainViewController()
        
        let feedCoodinator = FeedCoodinator(navigationController: navigationController)
        let firstGroupCoodinator = GroupCoodinator(navigationController: navigationController)
        let secondGroupCoodinator = GroupCoodinator(navigationController: navigationController, groupName: "DDang")
        let profileCoodinator = FeedCoodinator(navigationController: navigationController)
        
        childCoodinators = [
            feedCoodinator,
            firstGroupCoodinator,
            secondGroupCoodinator,
            profileCoodinator
        ]
        
        viewController.viewControllers = [
            feedCoodinator.setupTabBarItem(),
            firstGroupCoodinator.setupTabBarItem(),
            secondGroupCoodinator.setupTabBarItem(),
            profileCoodinator.setupTabBarItem()
        ]
        
        viewController.viewControllerDelegate = self
        viewController.view.backgroundColor = .white
        viewController.tabBar.barTintColor = .white
        viewController.tabBar.isTranslucent = false
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoodinator: MainViewControllerDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "그룹" {
            let coodinator = GroupGuideModalCoodinator(navigationController: self.navigationController)
            
            coodinator.delegate = self
            coodinator.start()
            self.childCoodinators.append(coodinator)
        }
    }
}

extension MainCoodinator: GroupGuideModalCoodinatorDelegate {
    func didMoveToSearchViewController() {
        let coodinator = self.childCoodinators.first { type(of: $0) == FeedCoodinator.self } as! FeedCoodinator
        let viewController = self.navigationController.topViewController as! MainViewController
        
        viewController.selectedIndex = viewController.viewControllers?.firstIndex { $0.tabBarItem.title == "피드" } ?? 0
        coodinator.showSearchViewController()
    }
}
