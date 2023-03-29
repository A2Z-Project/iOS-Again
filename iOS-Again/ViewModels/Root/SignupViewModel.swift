//
//  SignupViewModel.swift
//  iOS-Again
//
//  Created by DDang on 2023/03/29.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

import RxSwift
import RxCocoa

class SignupViewModel {
    
    fileprivate var currentNonce: String?
    
    func clickedGoogleSignupButton(_ viewController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            guard error == nil else { return }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // 사용자 정보 등록
            Auth.auth().signIn(with: credential) { _, _ in
                // 사용자 등록 후에 처리할 코드
            }
            // If sign in succeeded, display the app's main content View.
            
        }
    }
    
    func clickedAppleSignupButton(_ viewController: UIViewController) {
        FirebaseAuthentication().signInWithApple(window: viewController.view.window!)
    }
}
