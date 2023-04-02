import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol SignupAccountViewControllerDelegate {
    func dismiss()
    func confirm(_ userData: UserRegisterationModel)
}

class SignupAccountViewController: UIViewController {
    var delegate: SignupAccountViewControllerDelegate?
    var viewModel: SignupAccountViewModel?
    let disposeBag = DisposeBag()
    
    let backButton = AGBackButton()
    let topBar = AGTopBar(title: "회원가입", subTitle: "사용자님의 계정 정보를 입력해주세요.")
    let emailTextField = AGTextField(.emailAddress, title: "E-mail", placeholder: "이메일을 입력해주세요.")
    let passwordTextField = AGTextField(.password, title: "비밀번호", placeholder: "비밀번호를 입력해주세요. (8자 이상, 영어와 숫자 혼용)")
    let passwordConfirmTextField = AGTextField(.password, title: "비밀번호 확인", placeholder: "비밀번호를 다시 한번 입력해주세요.")
    let confirmButton = AGButton(title: "다음")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SignupAccountViewModel(self)
        
        self.configureLayout()
        self.didAction()
    }
}

extension SignupAccountViewController {
    func configureLayout() {
        [backButton, topBar, emailTextField, passwordTextField, passwordConfirmTextField, confirmButton].forEach { self.view.addSubview($0) }
        
        emailTextField.textField.delegate = self
        passwordTextField.textField.delegate = self
        passwordConfirmTextField.textField.delegate = self
        
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
        
        emailTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel!.emailTextRelay)
            .disposed(by: disposeBag)
        
        passwordTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel!.passwordTextRelay)
            .disposed(by: disposeBag)
        
        passwordConfirmTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel!.passwordConfirmTextRelay)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .withLatestFrom(
                Observable.combineLatest(
                    confirmButton.rx.tap,
                    viewModel!.emailValidate(),
                    viewModel!.passwordValidate(),
                    viewModel!.passwordConfirmValidate()
                ) { ($0, $1, $2, $3) }
            )
            .subscribe(onNext: { tap, isEmailValid, isPasswordValid, isPasswordConfirmValid in
                let alertController = UIAlertController(title: "입력 오류", message: "", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
                
                if !isEmailValid {
                    alertController.message = "입력된 이메일이 형식에 맞지 않습니다"
                    
                    self.present(alertController, animated: true)
                } else if !isPasswordValid {
                    alertController.message = "입력된 비밀번호이 형식에 맞지 않습니다 (8자 이상, 영어와 숫자 혼용)"
                    
                    self.present(alertController, animated: true)
                } else if !isPasswordConfirmValid {
                    alertController.message = "비밀번호가 동일하지 않습니다.\n다시 입력해주세요"
                    
                    self.present(alertController, animated: true)
                } else {
                    self.viewModel!.tappedNextButton(email: self.emailTextField.textField.text!, password: self.passwordTextField.textField.text!) { userData in
                        self.delegate?.confirm(userData)
                    }
                }
            }).disposed(by: disposeBag)
    }
}

extension SignupAccountViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
