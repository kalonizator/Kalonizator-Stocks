import UIKit

public extension UIFont {

  // MARK: regular
  static var regular14: UIFont { regularFont(14) }
  static var regular16: UIFont { regularFont(16) }
  static var regular20: UIFont { regularFont(20) }

  // MARK: - helper methods

  private static func regularFont(_ size: CGFloat) -> UIFont {
    let font = UIFont.systemFont(ofSize: size)
    return font
  }
}

private extension UIFont {
  static func adoptFontSize(_ size: CGFloat) -> CGFloat {
    //  Design was done on iPhone 12 mini with width of 375 points
    if (UIScreen.main.bounds.width != 375) // Only need code if not on original design size.
    {
      let scaleFactor: CGFloat = CGFloat(UIScreen.main.bounds.width) / 375
      let fontSize = CGFloat(size * scaleFactor)
      return fontSize
    }
    return size
  }
}
