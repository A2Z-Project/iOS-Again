import UIKit

protocol SearchViewCoodinatorDelegate {
    func didDismissSearchViewController(_ coodinator: SearchViewCoodinator)
}

class SearchViewCoodinator: Coodinator, SearchViewControllerDelegate {
    var childCoodinators: [Coodinator] = []
    var delegate: SearchViewCoodinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SearchViewController()
        
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismissViewController() {
        self.navigationController.popViewController(animated: true)
        self.delegate?.didDismissSearchViewController(self)
    }
}
