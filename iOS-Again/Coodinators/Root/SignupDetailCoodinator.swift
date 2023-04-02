import UIKit

protocol SignupDetailCoodinatorDelegate {
    func didDismissSignupDetailViewController(_ coodinator: SignupDetailCoodinator)
    func didConfirmSignup(_ coodinator: SignupDetailCoodinator, userData: UserRegisterationModel)
}

class SignupDetailCoodinator: Coodinator {
    var delegate: SignupDetailCoodinatorDelegate?
    var childCoodinators: [Coodinator] = []
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func start(_ userData: UserRegisterationModel) {
        let viewController =  SignupDetailViewController()
        
        viewController.delegate = self
        viewController.currentUserData = userData
        viewController.view.backgroundColor = .white
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension SignupDetailCoodinator: SignupDetailViewControllerDelegate {
    func dismiss() {
        self.navigationController.popViewController(animated: true)
        self.delegate?.didDismissSignupDetailViewController(self)
    }
    
    func confirmSignup(_ userData: UserRegisterationModel) {
        self.delegate?.didConfirmSignup(self, userData: userData)
    }
}
