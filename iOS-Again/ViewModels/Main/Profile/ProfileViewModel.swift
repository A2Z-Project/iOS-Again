//
//  ProfileViewModel.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/11.
//

import Foundation
import UIKit

class ProfileViewModel {
    var navigation: UINavigationController?
}

extension ProfileViewModel: ProfileViewControllerDelegate {
    func didTapEditProfileButton() {
        self.navigation?.pushViewController(EditProfileViewController(), animated: true)
    }
    
    func didTapOptionButton() {
        self.navigation?.pushViewController(UIViewController(), animated: true)
    }
}
