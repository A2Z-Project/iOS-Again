import UIKit

protocol MainViewControllerDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
}

class MainViewController: UITabBarController {
    var viewControllerDelegate: MainViewControllerDelegate?
    var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = MainViewModel()
        
        let feedViewController = FeedViewController()
        feedViewController.tabBarItem = UITabBarItem(title: "피드", image: .init(systemName: "list.bullet.rectangle"), selectedImage: .init(systemName: "list.bullet.rectangle.fill"))
        
        let groupViewController = GroupViewController()
        groupViewController.tabBarItem = UITabBarItem(title: "그룹", image: .init(systemName: "person.2.circle"), selectedImage: .init(systemName: "person.2.circle.fill"))
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "프로필", image: .init(systemName: "person.crop.circle"), selectedImage: .init(systemName: "person.crop.circle.fill"))
        
        self.tabBar.backgroundColor = .white
        self.viewControllers = [
            feedViewController,
            groupViewController,
            profileViewController
        ]
    }
}

extension MainViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.viewControllerDelegate?.tabBar(tabBar, didSelect: item)
    }
}
