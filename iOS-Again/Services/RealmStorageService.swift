//
//  RealmStorageService.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/13.
//

import Foundation
import RealmSwift

/// Realm을 사용하여 Local Data를 저장/로드
/// - Author: 김민규
/// - Date: 2023/06/12
class RealmStorageService {
    let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    /// User Data를 Local에 저장
    /// - Parameters:
    ///     - data: User Data
    /// - Author: 김민규
    /// - Date: 2023/06/12
    func writeUser(data: User) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    /// User Data를 로드
    /// - Returns: User Data
    /// - Author: 김민규
    /// - Date: 2023/06/12
    func getUser() -> User? {
        let users = realm.objects(User.self)
        return users.isEmpty ? nil : users[0]
    }
}
