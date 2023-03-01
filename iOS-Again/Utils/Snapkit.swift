import SnapKit
import UIKit

extension ConstraintMaker {
    func horizontalPaddingToSuperView(_ offset: Int) {
        self.leading.equalToSuperview().offset(offset)
        self.trailing.equalToSuperview().offset(-offset)
    }
}
