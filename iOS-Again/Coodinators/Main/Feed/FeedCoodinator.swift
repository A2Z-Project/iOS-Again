import UIKit

class FeedCoodinator: Coodinator, FeedViewControllerDelegate {
    var childCoodinators: [Coodinator] = []
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func setupTabBarItem() -> UIViewController {
        let viewController = FeedViewController()
        
        viewController.delegate = self
        viewController.tabBarItem.title = "피드"
        viewController.tabBarItem.image = UIImage(systemName: "doc")
        
        return viewController
    }
    
    func showSearchViewController() {
        let coodinator = SearchViewCoodinator(navigationController: self.navigationController)
        
        coodinator.delegate = self
        coodinator.start()
        self.childCoodinators.append(coodinator)
    }
}

extension FeedCoodinator: SearchViewCoodinatorDelegate {
    func didDismissSearchViewController(_ coodinator: SearchViewCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { coodinator !== $0 }
    }
}
