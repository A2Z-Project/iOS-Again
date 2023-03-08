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
        let firstGroupCoodinator = FeedCoodinator(navigationController: navigationController)
        let secondGroupCoodinator = FeedCoodinator(navigationController: navigationController)
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
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoodinator: MainViewControllerDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
