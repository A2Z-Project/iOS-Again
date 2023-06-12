import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

protocol SignupDetailViewControllerDelegate {
    func dismiss()
    func confirmSignup()
}

class SignupDetailViewController: UIViewController {
    var viewModel: SignupDetailViewModel?
    let disposeBag = DisposeBag()
    
    let backButton = AGBackButton()
    let topBar = AGTopBar(title: "회원가입", subTitle: "사용자님의 정보를 입력해주세요.")
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .lightGray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        return imageView
    }()
    let nicknameTextField = AGTextField(title: "이름(닉네임)", placeholder: "이름(닉네임)을 입력해주세요.")
    let confirmButton = AGButton(title: "회원가입 완료")
    
    init(userRegisterationModel: UserRegisterationModel) {
        self.viewModel = SignupDetailViewModel(userRegisterationModel: userRegisterationModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel?.viewController = self
        
        self.configureLayout()
        self.didAction()
    }
}

extension SignupDetailViewController {
    func configureLayout() {
        [profileImageView, nicknameTextField].forEach { self.infoStackView.addArrangedSubview($0) }
        [backButton, topBar, infoStackView, confirmButton].forEach { self.view.addSubview($0) }
        
        nicknameTextField.textField.delegate = self
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        topBar.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom).offset(20)
            make.horizontalPaddingToSuperView(15)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-5)
            make.horizontalPaddingToSuperView(15)
        }
    }
    
    func didAction() {
        backButton.rx.tap
            .bind {
                self.viewModel?.dismiss()
            }.disposed(by: disposeBag)
        
        profileImageView.rx.tapGesture()
            .when(.recognized)
            .subscribe (onNext: { _ in
                self.viewModel?.tappedProfileImageView()
            }).disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .bind {
                self.viewModel?.confirmSignup()
            }.disposed(by: disposeBag)
    }
}

extension SignupDetailViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
