import UIKit
import SnapKit
import SwiftUI
import RxSwift
import RxCocoa

protocol SignupViewControllerDelegate {
    func dismiss()
    func enterEmailSignup()
}

class SignupViewController: UIViewController {
    
    var delegate: SignupViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    let stackView: UIStackView = {
        let sv = UIStackView()

        sv.axis = .vertical
        sv.spacing = 10
        
        return sv
    }()
    let backButtonLayout: UIStackView = {
        let sv = UIStackView()
        
        sv.axis = .vertical
        sv.alignment = .leading
        
        return sv
    }()
    let backButton = AGBackButton()
    let topBar = AGTopBar(title: "회원가입", subTitle: "회원가입 방법을 선택해주세요")
    let emailSignupButton = AGButton(title: "이메일로 가입하기")
    let googleLoginButton = AGSnsAccountButton(.Google, usageType: .signup)
    let appleLoginButton = AGSnsAccountButton(.Apple, usageType: .signup)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
        self.didAction()
    }
}

extension SignupViewController {
    func configureLayout() {
        [backButton, topBar, emailSignupButton, googleLoginButton, appleLoginButton].forEach { self.view.addSubview($0) }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        topBar.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
        }
        
        emailSignupButton.snp.makeConstraints { make in
            make.bottom.equalTo(googleLoginButton.snp.top).offset(-10)
            make.horizontalPaddingToSuperView(15)
        }
        
        googleLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-10)
            make.horizontalPaddingToSuperView(15)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.horizontalPaddingToSuperView(15)
        }
    }
    
    func didAction() {
        backButton.rx.tap
            .bind {
                self.delegate?.dismiss()
            }.disposed(by: disposeBag)
        
        emailSignupButton.rx.tap
            .bind {
                self.delegate?.enterEmailSignup()
            }.disposed(by: disposeBag)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SignupViewController_Preview: PreviewProvider {
    static var previews: some View {
        SignupViewController().showPreview(.iPhone12Pro)
    }
}
#endif
