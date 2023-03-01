import UIKit

protocol SigninCoodinatorDelegate {
    func didDismissSigninViewController(_ coodinator: SigninCoodinator)
}

class SigninCoodinator: Coodinator, SigninViewControllerDelegate {
    
    var childCoodinators: [Coodinator] = []
    var delegate: SigninCoodinatorDelegate?
    
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SigninViewController()
        
        viewController.delegate = self
        viewController.view.backgroundColor = .systemBackground
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        self.navigationController.popViewController(animated: true)
        self.delegate?.didDismissSigninViewController(self)
    }
}
