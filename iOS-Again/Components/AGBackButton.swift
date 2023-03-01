import UIKit

class AGBackButton: UIButton {
    required init() {
        super.init(frame: .zero)
        
        self.setTitle("뒤로가기", for: .normal)
        self.titleLabel?.font = UIFont(type: NotoSansKR.regular, size: 18)
        
        self.setImage(UIImage(systemName: "arrow.left")?.withTintColor(UIColor(red: 16 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        self.setImage(UIImage(systemName: "arrow.left")?.withTintColor(UIColor(red: 6 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1), renderingMode: .alwaysOriginal), for: .highlighted)
        
        self.setTitleColor(UIColor(red: 16 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1), for: .normal)
        self.setTitleColor(UIColor(red: 6 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1), for: .highlighted)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
