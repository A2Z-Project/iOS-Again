import UIKit

protocol SignupCoodinatorDelegate {
    func didDismissSignupViewController(_ coodinator: SignupCoodinator)
}

class SignupCoodinator: Coodinator, SignupViewControllerDelegate {
    
    var childCoodinators: [Coodinator] = []
    var delegate: SignupCoodinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SignupViewController()
        
        viewController.delegate = self
        viewController.view.backgroundColor = .white
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        self.navigationController.popViewController(animated: true)
        self.delegate?.didDismissSignupViewController(self)
    }
}
