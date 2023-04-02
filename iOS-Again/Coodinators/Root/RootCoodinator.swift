import UIKit

import FirebaseMessaging

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
        viewController.view.backgroundColor = .white
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
    
    func didConfirmSignup(_ coodinator: SignupCoodinator, userData: UserRegisterationModel) {
        self.childCoodinators = self.childCoodinators.filter { $0 !== coodinator }
        
        let storage = FirebaseStorageService()
        let firestoreDatabase = FirebaseFirestoreDatabaseService()
        
        var userData = userData
        
        storage.uploadProfileImage(image: userData.profileImage!, pathRoot: userData.uid!) { url in
            if let url = url {
                userData.profileImageURL = url
                
                Messaging.messaging().token { token, error in
                    if let error = error {
                        print("Error fetching FCM registration token: \(error)")
                      } else if let token = token {
                          userData.fcmToken = token
                          
                          firestoreDatabase.registerUserData(userData) {
                              self.delegate?.didSignup(self)
                          }
                      }
                }
            }
        }
    }
}
