import UIKit

class AGTabBar: UIStackView {
    required init() {
        super.init(frame: .zero)
        
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 30
        
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 12, left: 22, bottom: 12, right: 22)
        
        if #available(iOS 14.0, *) {
            self.backgroundColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 0.4)
        } else {
            let backgroundColorView = UIView(frame: .zero)
            backgroundColorView.backgroundColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 0.4)
            backgroundColorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.addSubview(backgroundColorView)
            
            backgroundColorView.snp.makeConstraints { make in
                make.edges.equalTo(self)
            }
        }
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(visualEffectView)
        
        let apps: Array<UIView> = [{
            let view = UIView()
            
            view.backgroundColor = .white
            
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 10
            
            return view
        }(), {
            let view = UIView()
            
            view.backgroundColor = .white
            
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 10
            
            return view
        }(), {
            let view = UIView()
            
            view.backgroundColor = .white
            
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 10
            
            return view
        }(), {
            let view = UIView()
            
            view.backgroundColor = .white
            
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 10
            
            return view
        }()]
        
        apps.forEach { self.addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
