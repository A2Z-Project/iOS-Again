import UIKit

protocol SignupAccountCoodinatorDelegate {
    func didDismissSignupAccountCoodinatorDelegate(_ coodinator: SignupAccountCoodinator)
    func didConfirmSignup(_ coodinator: SignupAccountCoodinator)
}

class SignupAccountCoodinator: Coodinator, SignupAccountViewControllerDelegate {
    var childCoodinators: [Coodinator] = []
    var delegate: SignupAccountCoodinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SignupAccountViewController()
        
        viewController.delegate = self
        viewController.view.backgroundColor = .white
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        self.navigationController.popViewController(animated: true)
        self.delegate?.didDismissSignupAccountCoodinatorDelegate(self)
    }
    
    func confirm() {
        let coodinator = SignupDetailCoodinator(navigationController: navigationController)
        
        coodinator.delegate = self
        coodinator.start()
        self.childCoodinators.append(coodinator)
    }
}

extension SignupAccountCoodinator: SignupDetailCoodinatorDelegate {
    func didDismissSignupDetailViewController(_ coodinator: SignupDetailCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { coodinator !== $0 }
    }
    
    func didConfirmSignup(_ coodinator: SignupDetailCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { coodinator !== $0 }
        self.delegate?.didConfirmSignup(self)
    }
}
