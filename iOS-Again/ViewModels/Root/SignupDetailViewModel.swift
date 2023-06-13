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
    weak var viewController: SignupDetailViewController?
    var userRegisterationModel: UserRegisterationModel
    
    init(userRegisterationModel: UserRegisterationModel) {
        self.userRegisterationModel = userRegisterationModel
    }
    
    /// 프로필 사진 변경
    func tappedProfileImageView() {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        self.viewController?.present(imagePicker, animated: true)
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

extension SignupDetailViewModel: SignupDetailViewControllerDelegate {
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func confirmSignup() {
        if self.viewController!.nicknameTextField.textField.text!.isEmpty {
            let alertController = UIAlertController(title: "입력 오류", message: "닉네임을 입력해주세요", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
            
            self.viewController!.present(alertController, animated: true)
        } else {
            self.userRegisterationModel.nickname = self.viewController!.nicknameTextField.textField.text
            self.userRegisterationModel.profileImage = self.viewController!.profileImageView.image
            
            if let profileImage = self.userRegisterationModel.profileImage {
                FirebaseStorageService().uploadProfileImage(image: profileImage, pathRoot: "") { url in
                    self.userRegisterationModel.profileImageURL = url
                    
                    FirebaseFirestoreDatabaseService().registerUserData(self.userRegisterationModel) {
                        self.viewController?.navigationController?.popToRootViewController(animated: true)
                        self.viewController?.navigationController?.pushViewController(MainViewController(), animated: true)
                    }
                }
            } else {
                FirebaseFirestoreDatabaseService().registerUserData(self.userRegisterationModel) {
                    self.viewController?.navigationController?.popToRootViewController(animated: true)
                    self.viewController?.navigationController?.pushViewController(MainViewController(), animated: true)
                }
            }
        }
    }
}
