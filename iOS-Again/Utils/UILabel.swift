import UIKit

extension UILabel {
    
    /// Label Text에서 부분적으로 Font를 달리 적용하고자 할때 호출
    /// - Parameters:
    ///     - targetString: 적용하고자 하는 String
    ///     - font: 적용하고자 하는 Font
    /// - Author: 김민규
    /// - Date: 2023/03/02
    func asFont(targetString: String, font: UIFont) {
        let fullText = text ?? ""
        let attributtedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        
        attributtedString.addAttribute(.font, value: font, range: range)
        attributedText = attributtedString
    }
}
