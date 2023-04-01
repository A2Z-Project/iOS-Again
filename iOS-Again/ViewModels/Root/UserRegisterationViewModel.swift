//
//  UserRegisterationViewModel.swift
//  iOS-Again
//
//  Created by DDang on 2023/03/30.
//

import Foundation

struct UserRegisterationViewModel {
    var user: UserRegisterationModel
    
    init() {
        self.user = UserRegisterationModel()
    }
    
    init(_ user: UserRegisterationModel) {
        self.user = user
    }
}
