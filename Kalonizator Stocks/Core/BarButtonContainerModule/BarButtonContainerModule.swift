import UIKit

public protocol BarButtonContainerModule {

  func addRightBarButton(module: ToBarButtonItemConvertable)
  func addLeftBarButton(module: ToBarButtonItemConvertable)
}

public extension BarButtonContainerModule where Self: UIViewController {

  func addRightBarButton(module: ToBarButtonItemConvertable) {
    addToRight(barButton: module.barButtonItem)
  }

  func addLeftBarButton(module: ToBarButtonItemConvertable) {
    addToLeft(barButton: module.barButtonItem)
  }
}
