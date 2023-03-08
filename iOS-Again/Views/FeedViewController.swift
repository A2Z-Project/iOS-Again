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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
        self.didAction()
    }
}

extension FeedViewController {
    func configureLayout() {
        [header].forEach { self.view.addSubview($0) }
        
        header.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalPaddingToSuperView(0)
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
