import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol AGSearchBarDelegate {
    func tapBackButton()
}

class AGSearchBar: UIStackView {
    var delegate: AGSearchBarDelegate?
    let disposeBag = DisposeBag()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1.0).cgColor
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "그룹을 검색해보세요.", attributes: [
            .font: UIFont(type: NotoSansKR.light, size: 14)!,
            .foregroundColor: UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        ])
        textField.addLeftPadding()
        
        return textField
    }()
    
    required init() {
        super.init(frame: .zero)
        
        self.axis = .horizontal
        self.spacing = 10
        
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        self.backgroundColor = UIColor(red: 154 / 255, green: 214 / 255, blue: 214 / 255, alpha: 1.0)
        
        let backButton: UIButton = {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
            button.tintColor = UIColor(red: 16 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1)
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            button.imageEdgeInsets = UIEdgeInsets(top: 7.5, left: 7.5, bottom: 7.5, right: 7.5)
            
            return button
        }()
        
        [backButton, searchTextField].forEach { self.addArrangedSubview($0) }
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(45)
        }
        
        backButton.rx.tap
            .bind {
                self.delegate?.tapBackButton()
            }.disposed(by: disposeBag)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
