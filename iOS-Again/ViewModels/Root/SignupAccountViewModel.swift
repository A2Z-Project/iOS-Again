//
//  SignupAccountViewModel.swift
//  iOS-Again
//
//  Created by DDang on 2023/03/30.
//

import UIKit

import RxSwift
import RxRelay

import FirebaseAuth

struct SignupAccountViewModel {
    private var authService: FirebaseAuthService?
    
    let emailTextRelay = BehaviorRelay<String>(value: "")
    let passwordTextRelay = BehaviorRelay<String>(value: "")
    let passwordConfirmTextRelay = BehaviorRelay<String>(value: "")
    
    let disposeBag = DisposeBag()
    
    init(_ viewController: UIViewController) {
        self.authService = FirebaseAuthService(viewController)
    }
    
    func emailValidate() -> Observable<Bool> {
        return emailTextRelay.asObservable().map { email in
            return email.count > 0 && email.contains("@") && email.contains(".")
        }
    }
    
    func passwordValidate() -> Observable<Bool> {
        return passwordTextRelay.asObservable().map { password in
            return password.count >= 8
        }
    }
    
    func passwordConfirmValidate() -> Observable<Bool> {
        return Observable.combineLatest(passwordValidate(), passwordTextRelay, passwordConfirmTextRelay).map { isPasswordValid, password, passwordConfirm in
            return isPasswordValid && password == passwordConfirm
        }
    }
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(emailValidate(), passwordValidate(), passwordConfirmValidate()).map {
            return $0 && $1 && $2
        }
    }
    
    func tappedNextButton(email: String, password: String, completion: @escaping (Error?) -> Void) {
        self.authService?.emailSignup(email: email, password: password) { error in
            completion(error)
        }
    }
}
