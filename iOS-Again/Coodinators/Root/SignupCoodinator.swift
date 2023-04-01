import UIKit

protocol SignupCoodinatorDelegate {
    func didDismissSignupViewController(_ coodinator: SignupCoodinator)
    func didConfirmSignup(_ coodinator: SignupCoodinator)
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
    
    func enterEmailSignup(_ userData: UserRegisterationModel) {
        let coodinator = SignupAccountCoodinator(navigationController: navigationController)
        
        coodinator.delegate = self
        coodinator.start(userData)
        self.childCoodinators.append(coodinator)
    }
    
    func didSNSSignup(_ userData: UserRegisterationModel) {
        let coodinator = SignupDetailCoodinator(navigationController: navigationController)
        
        coodinator.delegate = self
        coodinator.start(userData)
        self.childCoodinators.append(coodinator)
    }
}

extension SignupCoodinator: SignupAccountCoodinatorDelegate {
    func didDismissSignupAccountCoodinatorDelegate(_ coodinator: SignupAccountCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { coodinator !== $0 }
    }
    
    func didConfirmSignup(_ coodinator: SignupAccountCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { coodinator !== $0 }
        self.delegate?.didConfirmSignup(self)
    }
}

extension SignupCoodinator: SignupDetailCoodinatorDelegate {
    func didDismissSignupDetailViewController(_ coodinator: SignupDetailCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { coodinator !== $0 }
    }
    
    func didConfirmSignup(_ coodinator: SignupDetailCoodinator) {
        self.childCoodinators = self.childCoodinators.filter { coodinator !== $0 }
        self.delegate?.didConfirmSignup(self)
    }
}
