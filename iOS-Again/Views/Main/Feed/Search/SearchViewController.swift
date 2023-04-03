import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol SearchViewControllerDelegate {
    func dismissViewController()
}

class SearchViewController: UIViewController {
    var delegate: SearchViewControllerDelegate?
    
    let searchBar = AGSearchBar()
    let searchResultTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AGFeedItem.self, forCellReuseIdentifier: AGFeedItem.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.searchTextField.delegate = self
        
        self.configureLayout()
        self.didAction()
    }
}

extension SearchViewController {
    func configureLayout() {
        [searchBar, searchResultTableView].forEach { self.view.addSubview($0) }
        
        searchBar.delegate = self
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalPaddingToSuperView(0)
        }
        
        searchResultTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.trailing.bottom.leading.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func didAction() {
        
    }
}

extension SearchViewController: AGSearchBarDelegate {
    func tapBackButton() {
        self.delegate?.dismissViewController()
    }
}

extension SearchViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lskjf", for: indexPath)
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

class SearchViewController_Preview: PreviewProvider {
    static var previews: some View {
        SearchViewController().showPreview()
    }
}
#endif
