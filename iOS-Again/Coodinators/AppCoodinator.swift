import UIKit

class AppCoodinator: Coodinator, RootCoodinatorDelegate {
    
    var childCoodinators: [Coodinator] = []
    private var navigationConroller: UINavigationController!
    
    var isLoggedIn: Bool = false
    
    init(navigationConroller: UINavigationController) {
        self.navigationConroller = navigationConroller
        self.navigationConroller.navigationBar.isHidden = true
    }
    
    func start() {
        if self.isLoggedIn {
            self.showMainViewController()
        } else {
            self.showRootViewController()
        }
    }
    
    func showMainViewController() {
        
    }
    
    func showRootViewController() {
        let coodinator = RootCoodinator(navigationController: self.navigationConroller)
        coodinator.delegate = self
        coodinator.start()
        self.childCoodinators.append(coodinator)
    }
    
    func didLoggedIn(_ coodinator: RootCoodinator) {
        self.childCoodinators = self.childCoodinators.filter{ coodinator !== $0 }
        self.showMainViewController()
    }
}