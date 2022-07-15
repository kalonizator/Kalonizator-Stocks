import UIKit

public protocol NavigationRouter: Routable { }

public class NavigationRouterImpl: NSObject, NavigationRouter {

  private let rootController: UINavigationController

  public init(rootController: UINavigationController) {
    self.rootController = rootController
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.backgroundColor = .white
      rootController.navigationBar.standardAppearance = navBarAppearance
      rootController.navigationBar.scrollEdgeAppearance = navBarAppearance
      rootController.navigationBar.tintColor = .black
      rootController.navigationBar.barTintColor = .black
    }
    super.init()
    rootController.delegate = self
  }

  public func toPresent() -> UIViewController? {
    return rootController
  }

  public func present(_ module: Presentable?, animated: Bool, completion: PresentCompletion?) {
    guard let controllerToPresent = module?.toPresent() else { return }
    var presenter: UIViewController = rootController
    while let presented = presenter.presentedViewController {
      presenter = presented
    }
    presenter.present(controllerToPresent, animated: animated, completion: completion)
  }

  public func dismissModule(animated: Bool, completion: (() -> Void)?) {
    rootController.dismiss(animated: animated, completion: completion)
  }

  public func push(_ module: Presentable?, animated: Bool) {
    var moduleToPresent = module

    if !rootController.viewControllers.isEmpty {
      moduleToPresent = moduleToPresent?.toPresent()?.withDisabledLargeTitle()
    }

    guard let controllerToPush = moduleToPresent?.toPresent() else { return }
    controllerToPush.navigationItem.backBarButtonItem = UIBarButtonItem(
      title: " ",
      style: .plain,
      target: nil,
      action: nil
    )

    rootController.pushViewController(controllerToPush, animated: animated)
  }

  public func popModule(animated: Bool) {
    rootController.popViewController(animated: animated)
  }

  public func popToSpecificModule(_ module: Presentable?, animated: Bool) {
    guard let viewController = module?.toPresent() else { return }
    rootController.popToViewController(viewController, animated: animated)
  }

  public func popToRootModule(animated: Bool) {
    rootController.popToRootViewController(animated: animated)
  }

  public func setRootModule(_ module: Presentable?, animated: Bool) {
    guard let controllerToSet = module?.toPresent() else { return }
    rootController.setViewControllers([controllerToSet], animated: animated)
  }

  public func removeModule(_ module: Presentable?) {
    guard let contollerToRemove = module?.toPresent() else { return }
    rootController.viewControllers.removeAll(where: { $0 === contollerToRemove })
  }

  public func showModule(_ module: Presentable?, animated: Bool) {
    guard let controllerToShow = module?.toPresent() else { return }
    rootController.popToViewController(controllerToShow, animated: animated)
  }
}

extension NavigationRouterImpl: UINavigationControllerDelegate {

  private func update(navigationController: UINavigationController, viewController: UIViewController, animated: Bool) {
    let barButtonItem = UIBarButtonItem(
      title: " ", style: .plain,
      target: nil,
      action: nil
    )
    viewController.navigationItem.backBarButtonItem = barButtonItem
    navigationController.setNavigationBarHidden(viewController.navigationBarHidden, animated: animated)
  }

  public func navigationController(
    _ navigationController: UINavigationController,
    willShow viewController: UIViewController,
    animated: Bool
  ) {
    update(navigationController: navigationController, viewController: viewController, animated: animated)
  }

  public func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    update(navigationController: navigationController, viewController: viewController, animated: animated)
  }
}
