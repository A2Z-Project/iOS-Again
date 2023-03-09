import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol FeedViewControllerDelegate {
    func showSearchViewController()
}

class FeedViewController: UIViewController {
    var delegate: FeedViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    let header = AGHeader()
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
        
        header.delegate = self
        header.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalPaddingToSuperView(0)
        }
    
        feedView.delegate = self
        feedView.dataSource = self
        feedView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.trailing.bottom.leading.equalToSuperview()
        }
    }
    
    func didAction() {
        
    }
}

extension FeedViewController: AGHeaderDelegate {
    func tapSearchButton() {
        self.delegate?.showSearchViewController()
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