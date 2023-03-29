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

#if canImport(SwiftUI) && DEBUG
import SwiftUI

class GroupGuideModalViewController_Preview: PreviewProvider {
    static var previews: some View {
        GroupGuideModalViewController().showPreview()
    }
}
#endif
