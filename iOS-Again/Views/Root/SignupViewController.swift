import UIKit
import SnapKit
import RxSwift
import RxCocoa

import AuthenticationServices
import CryptoKit
import FirebaseAuth

protocol SignupViewControllerDelegate {
    func dismiss()
    func didTapSignupButton(_ type: SignupType)
}

class SignupViewController: UIViewController {
    
    private var viewModel: SignupViewModel?
    let disposeBag = DisposeBag()
    fileprivate var currentNonce: String?
    
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
    let googleSignupButton = AGSnsAccountButton(.Google, usageType: .signup)
    let appleSignupButton = AGSnsAccountButton(.Apple, usageType: .signup)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SignupViewModel(self)
        
        self.configureLayout()
        self.didAction()
    }
}

extension SignupViewController {
    func configureLayout() {
        [backButton, topBar, emailSignupButton, googleSignupButton, appleSignupButton].forEach { self.view.addSubview($0) }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        topBar.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
        }
        
        emailSignupButton.snp.makeConstraints { make in
            make.bottom.equalTo(googleSignupButton.snp.top).offset(-10)
            make.horizontalPaddingToSuperView(15)
        }
        
        googleSignupButton.snp.makeConstraints { make in
            make.bottom.equalTo(appleSignupButton.snp.top).offset(-10)
            make.horizontalPaddingToSuperView(15)
        }
        
        appleSignupButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.horizontalPaddingToSuperView(15)
        }
    }
    
    func didAction() {
        backButton.rx.tap
            .bind {
                self.viewModel?.dismiss()
            }.disposed(by: disposeBag)
        
        emailSignupButton.rx.tap
            .bind {
                self.viewModel?.didTapSignupButton(.email)
            }.disposed(by: disposeBag)
        
        googleSignupButton.rx.tap
            .bind {
                self.viewModel?.didTapSignupButton(.google)
            }.disposed(by: disposeBag)
        
        appleSignupButton.rx.tap
            .bind {
                self.viewModel?.didTapSignupButton(.apple)
            }.disposed(by: disposeBag)
    }
}
