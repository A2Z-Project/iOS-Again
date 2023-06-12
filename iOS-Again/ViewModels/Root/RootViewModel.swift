//
//  RootViewModel.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/12.
//

import Foundation
import UIKit

class RootViewModel {
    weak var viewController: RootViewController?
    
    init(_ viewController: RootViewController) {
        self.viewController = viewController
    }
}

extension RootViewModel: RootViewControllerDelegate {
    func showSigninViewController() {
        self.viewController?.navigationController?.pushViewController(SigninViewController(), animated: true)
    }
    
    func showSignupViewController() {
        self.viewController?.navigationController?.pushViewController(SignupViewController(), animated: true)
    }
}
