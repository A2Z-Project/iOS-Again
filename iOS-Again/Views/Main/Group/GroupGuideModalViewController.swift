import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol GroupGuideModalViewControllerDelegate {
    func moveToSearchViewController()
}

class GroupGuideModalViewController: UIViewController {
    var delegate: GroupGuideModalViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
        self.didAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.delegate?.moveToSearchViewController()
    }
}

extension GroupGuideModalViewController {
    func configureLayout() {
        
    }
    
    func didAction() {
        
    }
}
