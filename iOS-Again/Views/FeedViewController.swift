import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol FeedViewControllerDelegate {
    
}

class FeedViewController: UIViewController {
    var delegate: FeedViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    let header = AGHeader()
    let scrollView = UIScrollView()
    let scrollContentView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        
        return stackView
    }()
    let feeds: [AGFeedItem] = [
        AGFeedItem(),
        AGFeedItem(),
        AGFeedItem(),
        AGFeedItem(),
        AGFeedItem()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
        self.didAction()
    }
}

extension FeedViewController {
    func configureLayout() {
        [header, scrollView].forEach { self.view.addSubview($0) }
        scrollView.addSubview(scrollContentView)
        feeds.forEach { scrollContentView.addArrangedSubview($0) }
        
        header.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalPaddingToSuperView(0)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.trailing.bottom.leading.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(scrollView.frame.size.height).priority(.low)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    func didAction() {
        
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

class FeedViewController_Preview: PreviewProvider {
    static var previews: some View {
        FeedViewController().showPreview()
    }
}
#endif
