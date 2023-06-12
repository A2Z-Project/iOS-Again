//
//  User.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/12.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var profileImageURL: String? = nil
    @objc dynamic var group: Group? = nil
}
