//
//  Group.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/13.
//

import Foundation
import RealmSwift

class Group: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var groupImageURL: String? = nil
    @objc dynamic var createdAt: Date = Date()
}
