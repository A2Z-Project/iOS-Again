import UIKit

struct UserRegisterationModel {
    var uid: String?
    var email: String?
    var password: String?
    var nickname: String?
    var profileImage: UIImage?
    var profileImageURL: URL?
    var fcmToken: String?
    
    init() {
        self.uid = nil
        self.email = nil
        self.password = nil
        self.nickname = nil
        self.fcmToken = nil
        self.profileImage = nil
        self.profileImageURL = nil
    }
    
    func exportData() -> [String:Any] {
        return [
            "uid": self.uid!,
            "email": self.email!,
            "password": self.password!,
            "nickname": self.nickname!,
            "profile_image_url": self.profileImageURL?.absoluteString ?? nil,
            "fcm_token": self.fcmToken ?? nil,
            "created_at": Date(),
            "updated_at": Date()
        ]
    }
}
