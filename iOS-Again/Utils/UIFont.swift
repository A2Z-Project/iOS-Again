import UIKit

enum NotoSansKR: String {
    case black = "NotoSansKR-Black"
    case bold = "NotoSansKR-Bold"
    case light = "NotoSansKR-Light"
    case medium = "NotoSansKR-Medium"
    case regular = "NotoSansKR-Regular"
    case thin = "NotoSansKR-Thin"
}

enum AllertaStencil: String {
    case regular = "AllertaStencil-Regular"
}

extension UIFont {
    convenience init?(type: NotoSansKR, size: CGFloat) {
        self.init(name: type.rawValue, size: size)
    }
    
    convenience init?(type: AllertaStencil, size: CGFloat) {
        self.init(name: type.rawValue, size: size)
    }
}
