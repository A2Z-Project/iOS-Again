import UIKit

protocol MainViewControllerDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
}

class MainViewController: UITabBarController {
    var viewControllerDelegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.viewControllerDelegate?.tabBar(tabBar, didSelect: item)
    }
}
