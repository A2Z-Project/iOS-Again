import UIKit

class AGTopBar: UIStackView {
    
    required init(title: String, subTitle: String) {
        super.init(frame: .zero)
        
        self.axis = .vertical
        self.alignment = .leading
        
        let titleLabel: UILabel = {
            let label = UILabel()
            
            label.text = title
            label.font = UIFont(type: NotoSansKR.bold, size: 36)
            
            return label
        }()
        let subTitleLabel: UILabel = {
            let label = UILabel()
            
            label.text = subTitle
            label.font = UIFont(type: NotoSansKR.light, size: 20)
            
            return label
        }()
        
        [titleLabel, subTitleLabel].forEach { self.addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
