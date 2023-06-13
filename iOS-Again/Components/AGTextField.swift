import UIKit
import SnapKit

/// Again Component: TextField Type
enum AGTextFieldType {
    /// Plain
    case none
    
    /// Email Form
    case emailAddress
    
    /// Password Form
    case password
}

/// Again Component: TextField
/// - Author: 김민규
/// - Date: 2023/03/02
class AGTextField: UIStackView {
    var textField: UITextField = {
        let tf = UITextField()
        
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10
        tf.addLeftPadding()
        
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    /// Again Component: TextField Initializer
    /// - Parameters:
    ///     - type: TextField Type
    ///     - title: TextField Title(Description)
    ///     - placeholder: TextField Placeholder
    /// - Author: 김민규
    /// - Date: 2023/03/02
    required init(_ type: AGTextFieldType = .none, title: String, placeholder: String) {
        super.init(frame: .zero)
        
        self.axis = .vertical
        self.alignment = .fill
        
        let titleLabel: UILabel = {
            let label = UILabel()
            
            label.text = title
            label.font = UIFont(type: NotoSansKR.light, size: 20)
            label.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
            
            return label
        }()
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        /// TextField Type에 따라 키보드 표시 배열과 TextField 표시 텍스트을 분기
        switch type {
        case .emailAddress:
            textField.keyboardType = .emailAddress
            break
        case .password:
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
            textField.textContentType = .newPassword
            break
        default:
            textField.keyboardType = .default
        }
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .font: UIFont(type: NotoSansKR.light, size: 14)!,
            .foregroundColor: UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        ])
        
        [titleLabel, textField].forEach { self.addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
