import UIKit

protocol RootCoodinatorDelegate {
    func didLoggedIn(_ coodinator: RootCoodinator)
    func didSignup(_ coodinator: RootCoodinator)
}

class RootCoodinator: Coodinator, RootViewControllerCoodinator {
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
}

extension RootCoodinator: SigninCoodinatorDelegate {
    func didDismissSigninViewController(_ coodinator: SigninCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { $0 !== coodinator }
    }
    
    func didLoggedIn(_ coodinator: SigninCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { $0 !== coodinator }
        self.delegate?.didLoggedIn(self)
    }
}

extension RootCoodinator: SignupCoodinatorDelegate {
    func didDismissSignupViewController(_ coodinator: SignupCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { $0 !== coodinator }
    }
    
    func didConfirmSignup(_ coodinator: SignupCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { $0 !== coodinator }
        self.delegate?.didSignup(self)
    }
}
