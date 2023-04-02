//
//  SignupViewModel.swift
//  iOS-Again
//
//  Created by DDang on 2023/03/29.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import CryptoKit
import AuthenticationServices

class SignupViewModel {
    private var authService: FirebaseAuthService?
    
    private weak var viewController: SignupViewController?
    private var userRegisterationModel: UserRegisterationModel
    
    init(_ viewController: SignupViewController) {
        self.authService = FirebaseAuthService(viewController)
        self.viewController = viewController
        self.userRegisterationModel = UserRegisterationModel()
        
        self.authService?.delegate = self
    }
    
    func tappedGoogleSignupButton() {
        self.authService?.googleSignup()
    }
    
    func tappedAppleSignupButton() {
        self.authService?.appleSignup()
    }
}

extension SignupViewModel: FirebaseAuthServiceDelegate {
    func didSNSSignup(_ result: AuthDataResult) {
        self.userRegisterationModel.uid = result.user.uid
        self.userRegisterationModel.email = result.user.email
        self.viewController?.delegate?.didSNSSignup(userRegisterationModel)
    }
}
