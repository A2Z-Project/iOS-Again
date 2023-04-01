import UIKit
import FirebaseAuth

class AppCoodinator: Coodinator, RootCoodinatorDelegate {
    
    var childCoodinators: [Coodinator] = []
    private var navigationConroller: UINavigationController!
    
    init(navigationConroller: UINavigationController) {
        self.navigationConroller = navigationConroller
        self.navigationConroller.navigationBar.isHidden = true
    }
    
    func start() {
        self.showRootViewController()
//        if let currentUser = Auth.auth().currentUser {
//            self.showMainViewController()
//        } else {
//            self.showRootViewController()
//        }
    }
    
    func showMainViewController() {
        let coodinator = MainCoodinator(navigationController: self.navigationConroller)
        coodinator.start()
        self.childCoodinators.append(coodinator)
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
    
    func didSignup(_ coodinator: RootCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { coodinator !== $0 }
        self.navigationConroller.popToRootViewController(animated: true)
        self.showMainViewController()
    }
}
