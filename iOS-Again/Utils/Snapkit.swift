import SnapKit
import UIKit

extension ConstraintMaker {
    /// Snapkit으로 UI Layout 빌드할 경우, SuperView 기준으로 Leading, Trailing에 동시에 padding(offset)을 부여하고자 할 때 호출
    /// - Parameters:
    ///     - offset: padding(offset) Value
    func horizontalPaddingToSuperView(_ offset: Int) {
        self.leading.equalToSuperview().offset(offset)
        self.trailing.equalToSuperview().offset(-offset)
    }
}
