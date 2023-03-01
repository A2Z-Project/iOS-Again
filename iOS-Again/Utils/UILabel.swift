import UIKit

extension UILabel {
    func asFont(targetString: String, font: UIFont) {
        let fullText = text ?? ""
        let attributtedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        
        attributtedString.addAttribute(.font, value: font, range: range)
        attributedText = attributtedString
    }
}
