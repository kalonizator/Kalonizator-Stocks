import UIKit

extension UILabel {
  func setSemanticLeftTextAlignment() {
    switch UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) {
    case .leftToRight:
      textAlignment = .left
    case .rightToLeft:
      textAlignment = .right
    @unknown default:
      textAlignment = .left
    }
  }

  func setSemanticRightTextAlignment() {
    switch UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) {
    case .leftToRight:
      textAlignment = .right
    case .rightToLeft:
      textAlignment = .left
    @unknown default:
      textAlignment = .right
    }
  }
}
