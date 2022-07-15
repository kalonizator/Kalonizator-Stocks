import UIKit

public extension UILabel {

  convenience init(
    font: UIFont,
    numberOfLines: Int = 0
  ) {
    self.init()
    self.font = font
    self.numberOfLines = numberOfLines
  }
}
