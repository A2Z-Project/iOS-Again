import UIKit

class FeedCoodinator: Coodinator, FeedViewControllerDelegate {
    var childCoodinators: [Coodinator] = []
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = FeedViewController()
        
        viewController.delegate = self
        viewController.view.backgroundColor = .white
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func setupTabBarItem() -> UIViewController {
        let viewController = FeedViewController()
        
        viewController.tabBarItem.title = "피드"
        viewController.tabBarItem.image = UIImage(systemName: "doc")
        
        return viewController
    }
}
