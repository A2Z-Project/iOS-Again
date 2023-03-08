import UIKit
import SnapKit

protocol AGHeaderDelegate {
    
}

class AGHeader: UIStackView {
    required init() {
        super.init(frame: .zero)
        
        self.axis = .vertical
        
        let content: UIStackView = {
            let stackView = UIStackView()
            
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .equalSpacing
            
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            
            return stackView
        }()
        
        let logoButton: UIButton = {
            let button = UIButton()
            
            button.setTitle("Again", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont(type: AllertaStencil.regular, size: 20)
            
            return button
        }()
        let searchButton: UIButton = {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            button.tintColor = .black
            button.setBackgroundColor(UIColor(red: 16 / 255, green: 128 / 255, blue: 128 / 255, alpha: 0.5), for: .normal)
            
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            
            return button
        }()
        
        let line: UIView = {
            let view = UIView()
            
            view.backgroundColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
            
            return view
        }()
        
        [logoButton, searchButton].forEach { content.addArrangedSubview($0) }
        [content, line].forEach { self.addArrangedSubview($0) }
        
        content.snp.makeConstraints { make in
            make.height.equalTo(65)
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.height.equalTo(45)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(5)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
