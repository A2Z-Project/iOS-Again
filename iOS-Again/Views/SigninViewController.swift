import UIKit
import SnapKit
import SwiftUI
import RxSwift
import RxCocoa

protocol SigninViewControllerDelegate {
    func dismiss()
}

class SigninViewController: UIViewController {
    
    var delegate: SigninViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    let backButton = AGBackButton()
    let topBar = AGTopBar(title: "로그인", subTitle: "로그인 방법을 선택해주세요")
    let accountForm = AGAccountForm(.login)
    let divideLine = AGDivideLine("SNS 로그인")
    let googleLoginButton = AGSnsAccountButton(.Google, usageType: .signin)
    let appleLoginButton = AGSnsAccountButton(.Apple, usageType: .signin)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
        self.didAction()
    }
}

private extension SigninViewController {
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

struct SigninViewController_Preview: PreviewProvider {
    static var previews: some View {
        SigninViewController().showPreview(.iPhone12Pro)
    }
}
#endif
