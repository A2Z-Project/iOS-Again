import UIKit
import SnapKit

enum AGButtonState {
    case primary
    case pressed
}

enum AGSnsAccountButtonType: String {
    case Google
    case Apple
}

enum AGSnsAccountButtonUsageType: String {
    case signup = "가입"
    case signin = "로그인"
}

class AGButton: UIButton {
    required init(title: String) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(type: NotoSansKR.regular, size: 18)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 25
        self.setBackgroundColor(UIColor(red: 16 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1), for: .normal)
        self.setBackgroundColor(UIColor(red: 6 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1), for: .highlighted)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AGSnsAccountButton: UIButton {
    required init(_ type: AGSnsAccountButtonType, usageType: AGSnsAccountButtonUsageType) {
        super.init(frame: .zero)
        
        var conf = UIButton.Configuration.filled()
        
        self.setTitle("\(type.rawValue)로 \(usageType.rawValue)하기", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1.0).cgColor
        
        conf.imagePadding = 10
        conf.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        switch type {
        case .Apple:
            conf.baseBackgroundColor = .black
            self.setTitleColor(.white, for: .normal)
            self.setImage(UIImage.init(systemName: "apple.logo")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        case .Google:
            conf.baseBackgroundColor = .white
            self.setTitleColor(.black, for: .normal)
            self.setImage(UIImage(named: "google.logo"), for: .normal)
        }
        
        self.configuration = conf
        
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
