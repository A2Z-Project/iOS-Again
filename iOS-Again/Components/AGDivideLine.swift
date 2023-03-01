import UIKit
import SnapKit

class AGDivideLine: UIView {
    required init(_ text: String) {
        super.init(frame: .zero)
        
        let line: UIView = {
            let view = UIView()
            
            view.backgroundColor = UIColor(red: 6 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
            
            return view
        }()
        let textView: UILabel = {
            let tv = UILabel()
            
            tv.text = text
            tv.font = UIFont(type: NotoSansKR.light, size: 14)
            tv.textColor = UIColor(red: 16 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1.0)
            tv.backgroundColor = .white
            
            return tv
        }()
        
        [line, textView].forEach { self.addSubview($0) }
        
        line.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
            make.height.equalTo(2)
        }
        textView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
