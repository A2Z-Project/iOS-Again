import UIKit
import SnapKit

class AGTextField: UIStackView {
    required init(title: String, placeholder: String) {
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
        
        let textField: UITextField = {
            let tf = UITextField()
                
            tf.layer.borderWidth = 2
            tf.layer.borderColor = UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1.0).cgColor
            tf.layer.cornerRadius = 10
            tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
                .font: UIFont(type: NotoSansKR.light, size: 14)!,
                .foregroundColor: UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
            ])
            tf.addLeftPadding()
            
            return tf
        }()
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        [titleLabel, textField].forEach { self.addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
