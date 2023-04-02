//
//  SignupDetailViewModel.swift
//  iOS-Again
//
//  Created by DDang on 2023/04/03.
//

import UIKit

import RxCocoa
import RxSwift

class SignupDetailViewModel: NSObject {
    private weak var viewController: SignupDetailViewController?
    
    init(_ viewController: SignupDetailViewController) {
        self.viewController = viewController
    }
    
    func tappedProfileImageView() {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        self.viewController?.present(imagePicker, animated: true)
    }
    
    func tappedConfirmButton(completion: @escaping (UserRegisterationModel) -> Void) {
        if self.viewController!.nicknameTextField.textField.text!.isEmpty {
            let alertController = UIAlertController(title: "입력 오류", message: "닉네임을 입력해주세요", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
            
            self.viewController!.present(alertController, animated: true)
        } else {
            var currentUserData: UserRegisterationModel = self.viewController!.currentUserData!
            
            currentUserData.nickname = self.viewController!.nicknameTextField.textField.text
            currentUserData.profileImage = self.viewController!.profileImageView.image
            
            completion(currentUserData)
        }
    }
}

extension SignupDetailViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let edittedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.viewController?.profileImageView.image = edittedImage
            
            self.viewController?.dismiss(animated: true)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.viewController?.profileImageView.image = image
            
            self.viewController?.dismiss(animated: true)
        }
    }
}
