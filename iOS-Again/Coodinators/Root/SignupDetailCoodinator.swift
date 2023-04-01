import UIKit

protocol SignupDetailCoodinatorDelegate {
    func didDismissSignupDetailViewController(_ coodinator: SignupDetailCoodinator)
    func didConfirmSignup(_ coodinator: SignupDetailCoodinator)
}

class SignupDetailCoodinator: Coodinator, SignupDetailViewControllerDelegate {
    
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
        viewController.view.backgroundColor = .white
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        self.navigationController.popViewController(animated: true)
        self.delegate?.didDismissSignupDetailViewController(self)
    }
    
    func selectImage() {
        
    }
    
    func confirmSignup() {
        self.delegate?.didConfirmSignup(self)
    }
}
