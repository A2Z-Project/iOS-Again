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

enum SignupType {
    case email
    case google
    case apple
}

class SignupViewModel {
    private var authService: FirebaseAuthService?
    
    private weak var viewController: SignupViewController?
    
    init(_ viewController: SignupViewController) {
        self.authService = FirebaseAuthService(viewController)
        self.viewController = viewController
        
        self.authService?.delegate = self
    }
}

extension SignupViewModel: FirebaseAuthServiceDelegate {
    func didSNSSignup(_ result: AuthDataResult) {
        var userRegisterationModel = UserRegisterationModel()
        
        userRegisterationModel.uid = result.user.uid
        userRegisterationModel.email = result.user.email
        
        self.viewController?.navigationController?.pushViewController(SignupDetailViewController(userRegisterationModel: userRegisterationModel), animated: true)
    }
}

extension SignupViewModel: SignupViewControllerDelegate {
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func didTapSignupButton(_ type: SignupType) {
        switch type {
        case .email:
            self.viewController?.navigationController?.pushViewController(SignupAccountViewController(), animated: true)
        case .google:
            self.authService?.googleSignup()
        case .apple:
            self.authService?.appleSignup()
        }
    }
}
