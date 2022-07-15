import UIKit
import RxSwift
import RxCocoa

public extension UIView {

  private enum AssociatedKeys {
    static var emptyView = "empty_view_key"
  }

  private var emptyView: EmptyView! {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.emptyView) as? EmptyView
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKeys.emptyView, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  func showEmpty(
    _ title: String?,
    subtitle: String? = nil,
    buttonTitle: String? = nil,
    moveAction: (() -> Void)? = nil
  ) {
    emptyView?.removeFromSuperview()

    emptyView = EmptyView(
      title: title,
      subtitle: subtitle,
      buttonTitle: buttonTitle,
      moveAction: moveAction
    )
    emptyView.backgroundColor = backgroundColor
    addSubview(emptyView)
    emptyView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(48)
    }
  }

  func hideEmptyView() {
    emptyView?.removeFromSuperview()
    emptyView = nil
  }
}

public extension Reactive where Base: UIView {

  var isEmpty: Binder<(isEmpty: Bool, title: String, buttonTitle: String?, completionHandler: (() -> Void)?)> {
    Binder(base) { target, emptyResult in
      if emptyResult.isEmpty {
        target.showEmpty(
          emptyResult.title,
          subtitle: nil,
          buttonTitle: emptyResult.buttonTitle,
          moveAction: emptyResult.completionHandler
        )
      } else {
        target.hideEmptyView()
      }
    }
  }
}
