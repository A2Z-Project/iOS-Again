//
//  EditProfileViewModel.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/12.
//

import Foundation
import UIKit

class EditProfileViewModel: NSObject {
    var navigation: UINavigationController?
    
    var userData = User()
}

extension EditProfileViewModel: EditProfileViewControllerDelegate {
    func didTapBackButton() {
        self.navigation?.popViewController(animated: true)
    }
    
    func didTapProfileImageView() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        self.navigation?.present(imagePicker, animated: true)
    }
    
    func didTapConfirmButton() {
        self.navigation?.popViewController(animated: true)
    }
}

extension EditProfileViewModel: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            
//            self.userData.profileImage = image
        }
    }
}
