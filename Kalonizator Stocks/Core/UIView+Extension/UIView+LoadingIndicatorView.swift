import UIKit
import RxSwift
import RxCocoa

public extension UIView {

  private enum AssociatedKeys {
    static var activityKey = "activityKey"
  }

  private var activity: LoadingIndicatorView! {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.activityKey) as? LoadingIndicatorView
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKeys.activityKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  @objc func showActivity() {
    if activity != nil { return }

    activity = LoadingIndicatorView(style: .black)
    activity.backgroundColor = backgroundColor
    activity.startAnimating()
    addSubview(activity)
    activity.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  @objc func hideActivity() {
    activity?.stopAnimating()
    activity?.removeFromSuperview()
    activity = nil
  }
}

public extension Reactive where Base: UIView {

  var loading: Binder<Bool> {
    Binder(base) { target, loading in
      if loading {
        target.showActivity()
      } else {
        target.hideActivity()
      }
    }
  }
}
