import UIKit

public protocol NavigationBarConfigurable {
  var navigationBarHidden: Bool { get }
}

extension UIViewController: NavigationBarConfigurable {
  @objc open var navigationBarHidden: Bool { false }
}
