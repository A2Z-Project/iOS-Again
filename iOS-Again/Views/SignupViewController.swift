import UIKit
import SnapKit
import SwiftUI
import RxSwift
import RxCocoa

protocol SignupViewControllerDelegate {
    func dismiss()
}

class SignupViewController: UIViewController {
    
    var delegate: SignupViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    let backButton = AGBackButton()
    let topBar = AGTopBar(title: "회원 가입", subTitle: "회원 가입 방법을 선택해주세요")
    let accountForm = AGAccountForm(.signup)
    let divideLine = AGDivideLine("SNS 회원 가입")
    let googleLoginButton = AGSnsAccountButton(.Google, usageType: .signup)
    let appleLoginButton = AGSnsAccountButton(.Apple, usageType: .signup)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
    }
}

extension SignupViewController {
    func configureLayout() {
        [backButton, topBar, accountForm, divideLine, googleLoginButton, appleLoginButton].forEach { self.view.addSubview($0) }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        topBar.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
        }
        
        accountForm.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
        }
        
        divideLine.snp.makeConstraints { make in
            make.top.equalTo(accountForm.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
            make.height.equalTo(25)
        }
        
        googleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(divideLine.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(googleLoginButton.snp.bottom).offset(10)
            make.horizontalPaddingToSuperView(15)
        }
    }
    
    func didAction() {
        backButton.rx.tap
            .bind {
                self.delegate?.dismiss()
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
