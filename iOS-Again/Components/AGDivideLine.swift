import UIKit
import SnapKit

class AGDivideLine: UIView {
    required init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(red: 6 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
