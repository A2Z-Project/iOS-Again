import UIKit

protocol GroupCoodinatorDelegate {
    
}

class GroupCoodinator: Coodinator {
    var delegate: GroupCoodinatorDelegate?
    var childCoodinators: [Coodinator] = []
    
    private var navigationController: UINavigationController!
    private var groupName: String?
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    init(navigationController: UINavigationController!, groupName: String) {
        self.navigationController = navigationController
        self.groupName = groupName
    }
    
    func start() {}
    
    func setupTabBarItem() -> UIViewController {
        let viewController = GroupViewController()
        
        viewController.delegate = self
        viewController.tabBarItem.title = self.groupName ?? "그룹"
        viewController.tabBarItem.image = UIImage(systemName: "plus.app")
        
        return viewController
    }
}

extension GroupCoodinator: GroupViewControllerDelegate {
    
}
