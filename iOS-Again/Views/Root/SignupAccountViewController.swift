import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol SignupAccountViewControllerDelegate {
    func dismiss()
    func confirm()
}

class SignupAccountViewController: UIViewController {
    var delegate: SignupAccountViewControllerDelegate?
    let viewModel = SignupAccountViewModel()
    let disposeBag = DisposeBag()
    
    let backButton = AGBackButton()
    let topBar = AGTopBar(title: "회원가입", subTitle: "사용자님의 계정 정보를 입력해주세요.")
    let emailTextField = AGTextField(title: "E-mail", placeholder: "이메일을 입력해주세요.")
    let passwordTextField = AGTextField(title: "비밀번호", placeholder: "비밀번호를 입력해주세요. (8자 이상, 영어와 숫자 혼용)")
    let passwordConfirmTextField = AGTextField(title: "비밀번호 확인", placeholder: "비밀번호를 다시 한번 입력해주세요.")
    let confirmButton = AGButton(title: "다음")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
        self.didAction()
    }
}

extension SignupAccountViewController {
    func configureLayout() {
        [backButton, topBar, emailTextField, passwordTextField, passwordConfirmTextField, confirmButton].forEach { self.view.addSubview($0) }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        topBar.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.horizontalPaddingToSuperView(15)
        }
        
        passwordConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.horizontalPaddingToSuperView(15)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.horizontalPaddingToSuperView(15)
        }
    }
    
    func didAction() {
        backButton.rx.tap
            .bind {
                self.delegate?.dismiss()
            }.disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .bind {
                self.delegate?.confirm()
            }.disposed(by: disposeBag)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

class SignupAccountViewController_Preview: PreviewProvider {
    static var previews: some View {
        SignupAccountViewController().showPreview()
    }
}
#endif
