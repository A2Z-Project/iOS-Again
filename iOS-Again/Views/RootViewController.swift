import SwiftUI
import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol RootViewControllerCoodinator {
    func showSignInViewController()
    func showSignupViewController()
}

class RootViewController: UIViewController, UITextViewDelegate {
    
    var delegate: RootViewControllerCoodinator?
    let disposeBag = DisposeBag()
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        
        let logoImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "AppIcon"))
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 15
            return imageView
        }()
        let appTitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(type: AllertaStencil.regular, size: 36)
            label.text = "gain"
            return label
        }()
        
        [logoImageView, appTitleLabel].forEach { stackView.addArrangedSubview($0) }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        
        return stackView
    }()
    
    let explainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        let mainLabel: UILabel = {
            let label = UILabel()
            
            label.text = "스터디, 취미를 찾아 다시 시작!"
            label.font = UIFont(type: NotoSansKR.regular, size: 22)
            label.asFont(targetString: "다시 시작", font: UIFont(type: NotoSansKR.bold, size: 22)!)
            
            return label
        }()
        let subLabel: UILabel = {
            let label = UILabel()
            
            label.text = "나와 같은 관심사를 가지고 있는 사람들과 함께 성장해요!"
            label.font = UIFont(type: NotoSansKR.regular, size: 14)
            
            return label
        }()
        
        [mainLabel, subLabel].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    let loginButton: AGButton = {
        let button = AGButton(title: "로그인")
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        return button
    }()
    let signupButton: UIButton = {
        let button = AGButton(title: "회원 가입")
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        return button
    }()
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
        self.didAction()
    }
}

private extension RootViewController {
    func configureLayout() {
        self.view.addSubview(titleStackView)
        self.view.addSubview(explainStackView)
        self.view.addSubview(bottomStackView)
        
        [loginButton, signupButton].forEach { bottomStackView.addArrangedSubview($0) }
        
        titleStackView.snp.makeConstraints { make in
            make.horizontalPaddingToSuperView(15)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
        }
        
        explainStackView.snp.makeConstraints { make in
            make.horizontalPaddingToSuperView(15)
            make.top.equalTo(titleStackView.snp.bottom).offset(10)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.horizontalPaddingToSuperView(15)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
        }
    }
    
    func didAction() {
        loginButton.rx.tap
            .bind {
                self.delegate?.showSignInViewController()
            }.disposed(by: disposeBag)
        
        signupButton.rx.tap
            .bind {
                self.delegate?.showSignupViewController()
            }.disposed(by: disposeBag)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        RootViewController().showPreview(.iPhone12Pro)
    }
}
#endif
