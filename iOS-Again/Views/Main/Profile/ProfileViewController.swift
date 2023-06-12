//
//  ProfileViewController.swift
//  iOS-Again
//
//  Created by DDang on 2023/06/11.
//

import UIKit
import SnapKit
import RxSwift

protocol ProfileViewControllerDelegate {
    func didTapEditProfileButton()
    func didTapOptionButton()
}

class ProfileViewController: UIViewController {
    var viewModel: ProfileViewModel?
    let disposeBag = DisposeBag()
    
    let profileView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    let profileImageView: UIImageView = {
        let view = UIImageView()

        view.backgroundColor = UIColor(red: 153 / 255, green: 238 / 255, blue: 1, alpha: 1)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 75 / 2
        
        return view
    }()
    let profileInfoView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "User Name"
        label.font = UIFont(type: NotoSansKR.medium, size: 16)
        
        return label
    }()
    let groupTag = AGFeedItemGroupTag("Group Name")
    let menuView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    let editProfileButton: UIButton = {
        let button = UIButton()
        
        button.contentHorizontalAlignment = .leading
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        button.setTitle("프로필 수정", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(type: NotoSansKR.regular, size: 16)
        
        return button
    }()
    let divider: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        
        return view
    }()
    let optionButton: UIButton = {
        let button = UIButton()
        
        button.contentHorizontalAlignment = .leading
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        button.setTitle("옵션", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(type: NotoSansKR.regular, size: 16)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ProfileViewModel()
        self.viewModel?.navigation = self.navigationController
        
        self.configureLayout()
        self.didAction()
    }
}

extension ProfileViewController {
    func configureLayout() {
        nameLabel.text = viewModel?.userData.name
        if let profileImageURL = viewModel?.userData.profileImageURL {
            profileImageView.load(url: URL(string: profileImageURL)!)
        }
        
        [ nameLabel, groupTag ].forEach { profileInfoView.addArrangedSubview($0) }
        [ profileImageView, profileInfoView ].forEach { profileView.addArrangedSubview($0) }
        
        [ profileView, menuView ].forEach { self.view.addSubview($0) }
        [ editProfileButton, divider, optionButton ].forEach { menuView.addArrangedSubview($0) }
        menuView.addArrangedSubview({
            let spacer = UIView()
            
            spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
            
            return spacer
        }())
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(75)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            make.centerX.equalToSuperview()
        }
        
        menuView.snp.makeConstraints { make in
            make.top.equalTo(self.profileView.snp.bottom).offset(30)
            make.horizontalPaddingToSuperView(15)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        divider.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        optionButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func didAction() {
        editProfileButton.rx.tap
            .bind {
                self.viewModel?.didTapEditProfileButton()
            }.disposed(by: self.disposeBag)
        
        optionButton.rx.tap
            .bind {
                self.viewModel?.didTapOptionButton()
            }.disposed(by: self.disposeBag)
    }
}
