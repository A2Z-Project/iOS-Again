//
//  EditProfileViewController.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/12.
//

import Foundation
import UIKit
import RxSwift

protocol EditProfileViewControllerDelegate {
    func didTapBackButton()
    func didTapProfileImageView()
    func didTapConfirmButton()
}

class EditProfileViewController: UIViewController {
    var viewModel: EditProfileViewModel?
    let disposeBag = DisposeBag()
    
    let backButton = AGBackButton()
    let topBar = AGTopBar(title: "프로필 수정", subTitle: "수정할 사용자님의 정보를 입력해주세요.")
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: .init(systemName: "person.fill"))
        
        imageView.tintColor = .white
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
    let confirmButton = AGButton(title: "수정 완료")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = EditProfileViewModel()
        self.viewModel?.navigation = self.navigationController
        
        self.configureLayout()
        self.didAction()
    }
}

extension EditProfileViewController {
    func configureLayout() {
        self.view.backgroundColor = .white
        
//        profileImageView.image = self.viewModel?.userData.profileImageURL ?? UIImage(systemName: "person.fill")
        
        [profileImageView, nicknameTextField].forEach { self.infoStackView.addArrangedSubview($0) }
        [backButton, topBar, infoStackView, confirmButton].forEach { self.view.addSubview($0) }
        
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
                self.viewModel?.didTapBackButton()
            }.disposed(by: disposeBag)
        
        profileImageView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.viewModel?.didTapProfileImageView()
            }.disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .bind {
                self.viewModel?.didTapConfirmButton()
            }.disposed(by: disposeBag)
    }
}
