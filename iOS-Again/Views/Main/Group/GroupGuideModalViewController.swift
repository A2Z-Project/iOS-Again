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
    
    let numberOfPages = 3
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = true
        
        return pageControl
    }()
    let moveButton = AGButton(title: "그룹 검색하기")
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.isPagingEnabled = true
        
        scrollView.contentSize = CGSize(width: CGFloat(numberOfPages) * self.view.frame.maxX, height: 0)
        
        return scrollView
    }()
    
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
        [scrollView, pageControl, moveButton].forEach { self.view.addSubview($0) }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top)
            make.horizontalPaddingToSuperView(0)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(moveButton.snp.top)
            make.centerX.equalToSuperview()
        }
        
        moveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.horizontalPaddingToSuperView(15)
        }
    }
    
    func didAction() {
        
    }
}

extension GroupGuideModalViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
}
