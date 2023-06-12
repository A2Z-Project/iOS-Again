import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol SigninViewControllerDelegate {
    func dismiss()
    func login()
}

class SigninViewController: UIViewController {
    
    var delegate: SigninViewControllerDelegate?
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
    let topBar = AGTopBar(title: "로그인", subTitle: "로그인 방법을 선택해주세요")
    let idTextField = AGTextField(title: "E-mail", placeholder: "이메일을 입력해주세요.")
    let passwordTextField = AGTextField(title: "비밀번호", placeholder: "비밀번호를 입력해주세요. (8자 이상, 영어와 숫자 혼용)")
    let loginButton = AGButton(title: "로그인하기")
    let divideLine = AGDivideLine()
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
        backButtonLayout.addArrangedSubview(backButton)
        [backButtonLayout, topBar, idTextField, passwordTextField, loginButton, divideLine, googleLoginButton, appleLoginButton].forEach { stackView.addArrangedSubview($0) }
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.horizontalPaddingToSuperView(15)
        }
    }
    
    func didAction() {
        backButton.rx.tap
            .bind {
                self.delegate?.dismiss()
            }.disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind {
                self.delegate?.login()
            }.disposed(by: disposeBag)
    }
}
