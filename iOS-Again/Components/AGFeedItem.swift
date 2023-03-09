import UIKit
import SnapKit

class AGFeedItem: UITableViewCell {
    static let identifier = "agFeedCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let wrapper: UIStackView = {
            let stackView = UIStackView()
            
            stackView.axis = .vertical
            stackView.spacing = 10
            
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
            
            let header: UIStackView = {
                let stackView = UIStackView()
                
                stackView.axis = .horizontal
                stackView.alignment = .leading
                stackView.spacing = 10
                
                let profileImageView: UIImageView = {
                    let imageView = UIImageView()
                    
                    imageView.backgroundColor = UIColor(red: 153 / 255, green: 238 / 255, blue: 1, alpha: 1)
                    imageView.layer.masksToBounds = true
                    imageView.layer.cornerRadius = 22.5
                    
                    return imageView
                }()
                
                let profileVerticalStackView: UIStackView = {
                    let pvStackView = UIStackView()
                    
                    pvStackView.axis = .vertical
                    pvStackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                    
                    let profileNameLabel: UILabel = {
                        let label = UILabel()
                        
                        label.text = "User Name"
                        label.font = UIFont(type: NotoSansKR.medium, size: 16)
                        
                        return label
                    }()
                    
                    let profileGroupsStackView: UIStackView = {
                        let stackView = UIStackView()
                        
                        stackView.axis = .horizontal
                        stackView.alignment = .leading
                        stackView.spacing = 5
                        
                        let groupTags: [AGFeedItemGroupTag] = [
                            AGFeedItemGroupTag("Group Name"),
                            AGFeedItemGroupTag("Group Name")
                        ]
                        
                        groupTags.forEach { stackView.addArrangedSubview($0) }
                        stackView.addArrangedSubview({
                            let spacer = UIView()
                            
                            spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
                            
                            return spacer
                        }())
                        
                        return stackView
                    }()
                    
                    [profileNameLabel, profileGroupsStackView].forEach { pvStackView.addArrangedSubview($0) }
                    
                    return pvStackView
                }()
                
                let optionButton: UIButton = {
                    let button = UIButton()
                    
                    button.setImage(UIImage(systemName: "ellipsis")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
                    button.setBackgroundColor(UIColor(red: 187 / 255, green: 187 / 255, blue: 187 / 255, alpha: 1), for: .normal)
                    
                    button.layer.masksToBounds = true
                    button.layer.cornerRadius = 15
                    
                    return button
                }()
                
                [profileImageView, profileVerticalStackView, optionButton].forEach { stackView.addArrangedSubview($0) }
                
                profileImageView.snp.makeConstraints { make in
                    make.width.height.equalTo(45)
                }
                
                optionButton.snp.makeConstraints { make in
                    make.width.height.equalTo(30)
                }
                
                return stackView
            }()
            
            let contentTexts: UILabel = {
                let label = UILabel()
                
                label.text = "여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요. 여기에 Content를 써줘요."
                label.font = UIFont(type: NotoSansKR.regular, size: 12)
                
                label.numberOfLines = 5
                label.lineBreakMode = .byCharWrapping
                
                return label
            }()
            
            let actionStackView: UIStackView = {
                let stackView = UIStackView()
                
                stackView.axis = .horizontal
                stackView.alignment = .center
                stackView.spacing = 4
                
                let likeButton: UIButton = {
                    let button = UIButton()
                        
                    button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
                    
                    return button
                }()
                let likeLabel: UILabel = {
                    let label = UILabel()
                    
                    label.text = "0"
                    label.font = UIFont(type: NotoSansKR.regular, size: 11)
                    
                    return label
                }()
                
                let spacer: UIView = {
                    let view = UIView()
                    
                    view.setContentHuggingPriority(.defaultLow, for: .horizontal)
                    
                    return view
                }()
                
                [likeButton, likeLabel, spacer].forEach { stackView.addArrangedSubview($0) }
                
                likeButton.snp.makeConstraints { make in
                    make.width.height.equalTo(15)
                }
                
                return stackView
            }()
            
            [header, contentTexts, actionStackView].forEach { stackView.addArrangedSubview($0) }
            
            return stackView
        }()
        
        self.addSubview(wrapper)
        
        wrapper.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class AGFeedItemGroupTag: UILabel {
    required init(_ text: String) {
        super.init(frame: .zero)
        
        self.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        self.text = text
        self.font = UIFont(type: NotoSansKR.regular, size: 10)
        self.tintColor = UIColor(red: 102 / 255, green: 102 / 255, blue: 102 / 255, alpha: 1)
        
        self.backgroundColor = UIColor(red: 187 / 255, green: 187 / 255, blue: 187 / 255, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
    
    override func drawText(in rect: CGRect) {
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        
        contentSize.width += 10
        
        return contentSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
