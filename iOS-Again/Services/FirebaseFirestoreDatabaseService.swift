//
//  FirebaseFirestoreDatabaseService.swift
//  iOS-Again
//
//  Created by DDang on 2023/04/03.
//

import FirebaseCore
import FirebaseFirestore

class FirebaseFirestoreDatabaseService {
    let db = Firestore.firestore()
    
    func registerUserData(_ userData: UserRegisterationModel, completion: @escaping () -> Void) {
        db.collection("users").document(userData.uid!).setData(userData.exportData()) { err in
            if let err = err { } else {
                let user = User()
                user.name = userData.nickname!
                
                let realm = RealmStorageService()
                realm.writeUser(data: user)
                
                completion()
            }
        }
    }
}
