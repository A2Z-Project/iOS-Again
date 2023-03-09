import UIKit

protocol GroupGuideModalCoodinatorDelegate {
    func didMoveToSearchViewController()
}

class GroupGuideModalCoodinator: Coodinator {
    var delegate: GroupGuideModalCoodinatorDelegate?
    var childCoodinators: [Coodinator] = []
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = GroupGuideModalViewController()
        
        viewController.delegate = self
        viewController.view.backgroundColor = .white
        
        viewController.modalPresentationStyle = .pageSheet
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.navigationController.present(viewController, animated: true)
    }
}

extension GroupGuideModalCoodinator: GroupGuideModalViewControllerDelegate {
    func moveToSearchViewController() {
        self.delegate?.didMoveToSearchViewController()
    }
}
