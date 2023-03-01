import UIKit

enum AGAccountFormType: String {
    case login = "로그인"
    case signup = "회원 가입"
}

class AGAccountForm: UIStackView {
    required init(_ type: AGAccountFormType) {
        super.init(frame: .zero)
        
        self.axis = .vertical
        self.alignment = .fill
        self.spacing = 5
        
        let idTextField = AGTextField(title: "E-mail", placeholder: "이메일을 입력해주세요.")
        let passwordTextField = AGTextField(title: "비밀번호", placeholder: "비밀번호를 입력해주세요. (8자 이상, 영어와 숫자 혼용)")
        let confirmButton = AGButton(title: type.rawValue)
        
        [idTextField, passwordTextField, confirmButton].forEach {
            self.addArrangedSubview($0)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
