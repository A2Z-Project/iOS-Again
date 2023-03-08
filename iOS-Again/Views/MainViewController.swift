import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol MainViewControllerDelegate {
    
}

class MainViewController: UIViewController {
    var delegate: MainViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    let header = AGHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
        self.didAction()
    }
}

extension MainViewController {
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

class MainViewController_Preview: PreviewProvider {
    static var previews: some View {
        MainViewController().showPreview()
    }
}
#endif
