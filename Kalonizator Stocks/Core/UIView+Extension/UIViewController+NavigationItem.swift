import UIKit

public extension UIViewController {

  func addToRight(barButton: UIBarButtonItem) {
    navigationItem.rightBarButtonItems = (navigationItem.rightBarButtonItems ?? []) + [barButton]
  }

  func addToLeft(barButton: UIBarButtonItem) {
    navigationItem.leftBarButtonItems = (navigationItem.leftBarButtonItems ?? []) + [barButton]
  }
}
