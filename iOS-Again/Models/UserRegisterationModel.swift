import Foundation

struct UserRegisterationModel {
    let email: String?
    let password: String?
    let nickname: String?
    
    init() {
        self.email = nil
        self.password = nil
        self.nickname = nil
    }
}
