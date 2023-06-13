//
//  FirebaseFirestoreDatabaseService.swift
//  iOS-Again
//
//  Created by DDang on 2023/04/03.
//

import FirebaseCore
import FirebaseFirestore

/// Firebase Firestore를 사용하여 데이터 저장/로드
/// - Author: 김민규
/// - Date: 2023/04/02
class FirebaseFirestoreDatabaseService {
    let db = Firestore.firestore()
    
    /// User 데이터를 생성 및 저장
    /// - Parameters:
    ///     - userData: 회원가입 프로세스에 입력된 User Data
    ///     - completion: Database에 User Data가 저장되고 실행
    /// - Author: 김민규
    /// - Date: 2023/04/02
    func registerUserData(_ userData: UserRegisterationModel, completion: @escaping () -> Void) {
        db.collection("users").document(userData.uid!).setData(userData.exportData()) { err in
            if let err = err { } else {
                let user = User()
                user.name = userData.nickname!
                user.profileImageURL = userData.profileImageURL?.absoluteString
                
                let realm = RealmStorageService()
                realm.writeUser(data: user)
                
                completion()
            }
        }
    }
}
