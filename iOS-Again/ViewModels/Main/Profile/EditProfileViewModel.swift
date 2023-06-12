//
//  EditProfileViewModel.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/12.
//

import Foundation
import UIKit

class EditProfileViewModel {
    var navigation: UINavigationController?
}

extension EditProfileViewModel: EditProfileViewControllerDelegate {
    func didTapBackButton() {
        self.navigation?.popViewController(animated: true)
    }
    
    func didTapProfileImageView() {
        
    }
    
    func didTapConfirmButton() {
        self.navigation?.popViewController(animated: true)
    }
}
