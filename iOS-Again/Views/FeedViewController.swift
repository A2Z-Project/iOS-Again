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
    let feedView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AGFeedItem.self, forCellReuseIdentifier: AGFeedItem.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        return tableView
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
        [header, feedView].forEach { self.view.addSubview($0) }
//        scrollView.addSubview(scrollContentView)
//        feeds.forEach { scrollContentView.addArrangedSubview($0) }
        
        header.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalPaddingToSuperView(0)
        }
        
//        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(header.snp.bottom)
//            make.trailing.bottom.leading.equalToSuperview()
//        }
//
//        scrollContentView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView.contentLayoutGuide)
//            make.height.greaterThanOrEqualTo(scrollView.frame.size.height).priority(.low)
//            make.width.equalTo(scrollView.snp.width)
//        }
    
        feedView.delegate = self
        feedView.dataSource = self
        feedView.estimatedRowHeight = 100
        feedView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.trailing.bottom.leading.equalToSuperview()
        }
    }
    
    func didAction() {
        
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AGFeedItem.identifier, for: indexPath) as! AGFeedItem
        return cell
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
