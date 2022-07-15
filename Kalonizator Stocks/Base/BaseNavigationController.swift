import UIKit

open class BaseNavigationController: UINavigationController, Routable {

  private var rootController: UINavigationController {
    self
  }

  private let appearanceConfigurator = NavigationAppearanceConfigurator()

  open override func viewDidLoad() {
    super.viewDidLoad()
    appearanceConfigurator.configure(navigationController: self)
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
      moduleToPresent = moduleToPresent?.toPresent()
    }

    guard let controllerToPush = moduleToPresent?.toPresent() else { return }
    controllerToPush.navigationItem.backBarButtonItem = UIBarButtonItem(
      title: " ",
      style: .plain,
      target: nil,
      action: nil
    )
    controllerToPush.navigationItem.backButtonTitle = " "
    // Won't show the same screen
    if let topController = rootController.topViewController,
       topController === controllerToPush { return }

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

  public func setModules(_ modules: [Presentable?], animated: Bool) {
    let controllers = modules.compactMap { $0?.toPresent() }
    rootController.setViewControllers(controllers, animated: animated)
  }

  public func showModule(_ module: Presentable?, animated: Bool) {
    guard let controllerToShow = module?.toPresent() else { return }
    rootController.popToViewController(controllerToShow, animated: animated)
  }
}

final class NavigationAppearanceConfigurator: NSObject {

  func configure(navigationController: UINavigationController) {
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.backgroundColor = .white
      navigationController.navigationBar.standardAppearance = navBarAppearance
      navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
      navigationController.navigationBar.tintColor = .black
      navigationController.navigationBar.barTintColor = .black
    }
    navigationController.delegate = self
  }
}

extension NavigationAppearanceConfigurator: UINavigationControllerDelegate {

  private func update(navigationController: UINavigationController, viewController: UIViewController, animated: Bool) {
    let barButtonItem = UIBarButtonItem(
      title: " ", style: .plain,
      target: nil,
      action: nil
    )
    viewController.navigationItem.backBarButtonItem = barButtonItem
    navigationController.setNavigationBarHidden(viewController.navigationBarHidden, animated: animated)
  }

  func navigationController(
    _ navigationController: UINavigationController,
    willShow viewController: UIViewController,
    animated: Bool
  ) {
    guard animated, let transitionCoordinator = navigationController.transitionCoordinator else {
      update(navigationController: navigationController, viewController: viewController, animated: animated)
      return
    }

    let savedViewController = navigationController.viewControllers.last { $0 !== viewController }
    transitionCoordinator.animateAlongsideTransition(
      in: navigationController.view,
      animation: { [weak self] _ in
        self?.update(navigationController: navigationController, viewController: viewController, animated: animated)
      }, completion: { [weak self] context in
        if context.isCancelled {
          self?.update(
            navigationController: navigationController,
            viewController: savedViewController ?? viewController,
            animated: animated
          )
        }
      }
    )
  }
}
