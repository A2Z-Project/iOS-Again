import UIKit

protocol RootCoodinatorDelegate {
    func didLoggedIn(_ coodinator: RootCoodinator)
}

class RootCoodinator: Coodinator, RootViewControllerCoodinator, SigninCoodinatorDelegate, SignupCoodinatorDelegate {
    
    var childCoodinators: [Coodinator] = []
    var delegate: RootCoodinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RootViewController()
        
        viewController.delegate = self
        viewController.view.backgroundColor = .systemBackground
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func showSignInViewController() {
        let coodinator = SigninCoodinator(navigationController: navigationController)
        coodinator.delegate = self
        coodinator.start()
        self.childCoodinators.append(coodinator)
    }
    
    func showSignupViewController() {
        let coodinator = SignupCoodinator(navigationController: navigationController)
        coodinator.delegate = self
        coodinator.start()
        self.childCoodinators.append(coodinator)
    }
    
    func didDismissSigninViewController(_ coodinator: SigninCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { $0 !== coodinator }
        print(self.childCoodinators)
    }
    
    func didDismissSignupViewController(_ coodinator: SignupCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { $0 !== coodinator }
    }
}
