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
    private weak var viewController: SignupAccountViewController?
    private var authService: FirebaseAuthService?
    
    /// 이메일 Textfield Text
    let emailTextRelay = BehaviorRelay<String>(value: "")
    /// 비밀번호 Textfield Text
    let passwordTextRelay = BehaviorRelay<String>(value: "")
    /// 비밀번호 확인 Textfield Text
    let passwordConfirmTextRelay = BehaviorRelay<String>(value: "")
    
    let disposeBag = DisposeBag()
    
    init(_ viewController: SignupAccountViewController) {
        self.viewController = viewController
        self.authService = FirebaseAuthService(viewController)
    }
    
    /// 이메일 Textfield Text Validation
    func emailValidate() -> Observable<Bool> {
        return emailTextRelay.asObservable().map { email in
            return email.count > 0 && email.contains("@") && email.contains(".")
        }
    }
    
    /// 패스워드 Textfield Text Validation
    func passwordValidate() -> Observable<Bool> {
        return passwordTextRelay.asObservable().map { password in
            return password.count >= 8
        }
    }
    
    /// 패스워드 확인 Textfield Text Validation
    func passwordConfirmValidate() -> Observable<Bool> {
        return Observable.combineLatest(passwordValidate(), passwordTextRelay, passwordConfirmTextRelay).map { isPasswordValid, password, passwordConfirm in
            return isPasswordValid && password == passwordConfirm
        }
    }
    
    /// 이메일, 패스워드, 패스워드 확인 Validation
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(emailValidate(), passwordValidate(), passwordConfirmValidate()).map {
            return $0 && $1 && $2
        }
    }
}

extension SignupAccountViewModel: SignupAccountViewControllerDelegate {
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func confirm(email: String, password: String) {
        self.authService?.emailSignup(email: email, password: password) { result in
            if result != nil {
                var userData = UserRegisterationModel()
                
                userData.uid = result!.user.uid
                userData.email = email
                userData.password = password
                
                self.viewController?.navigationController?.pushViewController(SignupDetailViewController(userRegisterationModel: userData), animated: true)
            } else {
                let alertController = UIAlertController(title: "가입 오류", message: "가입 처리 중 오류가 발생했습니다.\n잠시 후에 다시 시도해주세요", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
                
                self.viewController!.present(alertController, animated: true)
            }
        }
    }
}
