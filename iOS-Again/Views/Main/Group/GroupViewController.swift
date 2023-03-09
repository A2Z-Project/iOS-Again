import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol GroupViewControllerDelegate {
    
}

class GroupViewController: UIViewController {
    var delegate: GroupViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension GroupViewController {
    func configureLayout() {
        
    }
    
    func didAction() {
        
    }
}
