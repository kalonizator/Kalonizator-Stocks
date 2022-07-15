import UIKit
import RxSwift
import RxCocoa

public extension UIView {

  private struct AssociatedKeys {
    static var errorView = "error_view_key"
  }

  private var errorView: ErrorView! {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.errorView) as? ErrorView
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKeys.errorView, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  func showError(
    _ error: Error,
    retryAction: (() -> Void)? = nil
  ) {
    errorView?.removeFromSuperview()

    errorView = ErrorView(
      error: error,
      retryAction: retryAction ?? { [weak self] in self?.defaultRetry() }
    )
    errorView.backgroundColor = backgroundColor
    addSubview(errorView)
    errorView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  func hideError() {
    errorView?.removeFromSuperview()
    errorView = nil
  }

  @objc fileprivate func defaultRetry() {}
}

public extension Reactive where Base: UIView {

  var error: Binder<Error> {
    Binder(base) { target, error in
      if case let ApiError.mapException(error) = error {
        target.applyInputErrors(from: error.errors)
      } else {
        target.showError(error)
      }
    }
  }

  var retryAction: Observable<Void> {
    methodInvoked(#selector(base.defaultRetry))
      .map { _ in }
      .do(onNext: { [weak base] in base?.hideError() })
  }
}
