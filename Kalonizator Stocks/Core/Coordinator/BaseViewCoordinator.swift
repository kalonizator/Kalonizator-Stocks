import UIKit
import Swinject

public protocol BaseCoordinator: Coordinator {

  var router: Routable { get }
  var assembler: Assembler { get }
}

open class BaseViewCoordinator: UIViewController, BaseCoordinator {

  public let router: Routable
  public let assembler: Assembler

  open override var childForStatusBarStyle: UIViewController? {
    router.toPresent()
  }

  open override var childForHomeIndicatorAutoHidden: UIViewController? {
    router.toPresent()
  }

  open override var childForStatusBarHidden: UIViewController? {
    router.toPresent()
  }

  open override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
    router.toPresent()
  }

  open override var childViewControllerForPointerLock: UIViewController? {
    router.toPresent()
  }

  open override var transitionCoordinator: UIViewControllerTransitionCoordinator? {
    router.toPresent()?.transitionCoordinator
  }

  public init(assembler: Assembler, router: Routable) {
    self.assembler = assembler
    self.router = router
    super.init(nibName: nil, bundle: nil)
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {}

  open func start() {
    fatalError("Implement 'start' method in \(self.self)")
  }

  open func handle(deepLink: DeepLink?) {}

  open override func viewDidLoad() {
    super.viewDidLoad()
    addRouterAsChild()
  }

  private func addRouterAsChild() {
    guard let routerViewController = router.toPresent() else { return }
    addChild(routerViewController)
    view.addSubview(routerViewController.view)
    routerViewController.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    didMove(toParent: routerViewController)
  }
}

// MARK: Support

public extension BaseViewCoordinator {

  var lastPresentedViewController: UIViewController? {
    var viewController = router.toPresent()?.presentedViewController
    while let presented = viewController?.presentedViewController {
      viewController = presented
    }
    return viewController
  }
}
