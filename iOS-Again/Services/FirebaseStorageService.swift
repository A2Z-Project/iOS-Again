//
//  FirebaseStorageService.swift
//  iOS-Again
//
//  Created by DDang on 2023/04/03.
//

import UIKit
import FirebaseStorage

/// Firebase Storage를 사용하여 프로필 사진 등을 저장
/// - Author: 김민규
/// - Date: 2023/04/02
class FirebaseStorageService {
    
    /// 프로필 사진을 저장
    /// - Parameters:
    ///     - image: 프로필 사진
    ///     - pathRoot: 저장될 경로
    ///     - completion: 저장된 프로필 사진 URL을 리턴.
    func uploadProfileImage(image: UIImage, pathRoot: String, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        
        let firebaseReference = Storage.storage().reference().child("users/\(imageName)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                completion(url)
            }
        }
    }
}
