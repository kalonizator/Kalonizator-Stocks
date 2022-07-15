import UIKit
import SnapKit

public final class SimpleRouter: UIViewController, Routable {

  public override var childForStatusBarStyle: UIViewController? {
    rootViewController
  }

  public override var childForHomeIndicatorAutoHidden: UIViewController? {
    rootViewController
  }

  public override var childForStatusBarHidden: UIViewController? {
    rootViewController
  }

  public override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
    rootViewController
  }

  public override var childViewControllerForPointerLock: UIViewController? {
    rootViewController
  }

  private var rootViewController: UIViewController? {
    willSet {
      rootViewController?.willMove(toParent: nil)
      rootViewController?.view.removeFromSuperview()
      rootViewController?.removeFromParent()
    } didSet {
      guard let rootViewController = rootViewController else { return }
      addChild(rootViewController)
      view.addSubview(rootViewController.view)
      rootViewController.view.snp.makeConstraints { $0.edges.equalToSuperview() }
      rootViewController.didMove(toParent: self)
    }
  }

  public func present(_ module: Presentable?, animated: Bool, completion: PresentCompletion?) {
    guard let controllerToPresent = module?.toPresent() else { return }
    var presenter: UIViewController = self
    while let presented = presenter.presentedViewController {
      presenter = presented
    }
    presenter.present(controllerToPresent, animated: true, completion: completion)
  }

  public func dismissModule(animated: Bool, completion: (() -> Void)?) {
    dismiss(animated: animated, completion: completion)
  }

  public func setRootModule(_ module: Presentable?, animated: Bool) {
    rootViewController = module?.toPresent()
  }

  public func push(_ module: Presentable?, animated: Bool) {
    fatalError("Should be configured")
  }

  public func popModule(animated: Bool) {
    fatalError("Should be configured")
  }

  public func popToSpecificModule(_ module: Presentable?, animated: Bool) {
    fatalError("Should be configured")
  }

  public func popToRootModule(animated: Bool) {
    fatalError("Should be configured")
  }

  public func removeModule(_ module: Presentable?) {
    fatalError("Should be configured")
  }

  public func setModules(_ modules: [Presentable?], animated: Bool) {
    fatalError("Should be configured")
  }

  public func showModule(_ module: Presentable?, animated: Bool) {
    fatalError("Should be configured")
  }
}
