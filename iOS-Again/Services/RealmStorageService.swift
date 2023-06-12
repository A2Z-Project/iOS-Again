//
//  RealmStorageService.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/13.
//

import Foundation
import RealmSwift

class RealmStorageService {
    let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func writeUser(data: User) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getUser() -> User? {
        let users = realm.objects(User.self)
        return users.isEmpty ? nil : users[0]
    }
}
