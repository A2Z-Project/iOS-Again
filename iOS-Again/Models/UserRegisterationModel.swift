import UIKit

struct UserRegisterationModel: Codable {
    var email: String?
    var password: String?
    var nickname: String?
    var profileImage: String?
    
    init() {
        self.email = nil
        self.password = nil
        self.nickname = nil
        self.profileImage = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case email = "user_id"
        case password
        case nickname
        case profileImage = "user_profile_image_url"
    }
}
