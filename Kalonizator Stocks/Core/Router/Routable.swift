public protocol Routable: Presentable, AnyObject {

  typealias PresentCompletion = () -> Void

  func present(_ module: Presentable?, animated: Bool, completion: PresentCompletion?)
  func present(_ module: Presentable?, style: PresentationStyle, animated: Bool, completion: PresentCompletion?)

  func push(_ module: Presentable?)
  func push(_ module: Presentable?, animated: Bool)

  func popModule()
  func popModule(animated: Bool)

  func popToRootModule()
  func popToSpecificModule(_ module: Presentable?, animated: Bool)
  func popToRootModule(animated: Bool)

  func dismissModule()
  func dismissModule(animated: Bool, completion: (() -> Void)?)

  func setRootModule(_ module: Presentable?)
  func setRootModule(_ module: Presentable?, animated: Bool)

  func removeModule(_ module: Presentable?)

  func showModule(_ module: Presentable?, animated: Bool)
}

public extension Routable {

  func present(
    _ module: Presentable?,
    style: PresentationStyle = .fullScreen,
    animated: Bool = true,
    completion: PresentCompletion? = nil
  ) {
    present(module?.withPresentation(style: style), animated: animated, completion: completion)
  }

  func push(_ module: Presentable?) {
    push(module, animated: true)
  }

  func popModule() {
    popModule(animated: true)
  }

  func popToRootModule() {
    popToRootModule(animated: true)
  }

  func dismissModule() {
    dismissModule(animated: true, completion: nil)
  }

  func dismissModule(completion: (() -> Void)?) {
    dismissModule(animated: true, completion: completion)
  }

  func setRootModule(_ module: Presentable?) {
    setRootModule(module, animated: true)
  }

  func showModule(_ module: Presentable?) {
    showModule(module, animated: true)
  }
}

private extension Presentable {

  func withPresentation(style: PresentationStyle) -> Presentable? {
    guard let controllerToPresent = toPresent() else { return nil }

    switch style {
    case .fullScreen:
      controllerToPresent.modalPresentationStyle = .fullScreen
    case .pageSheet:
      controllerToPresent.modalPresentationStyle = .pageSheet
    case .overCurrentContext:
      controllerToPresent.modalPresentationStyle = .overCurrentContext
    case .overFullScreen:
      controllerToPresent.modalPresentationStyle = .overFullScreen
    case .custom:
      controllerToPresent.modalPresentationStyle = .custom
    }

    return controllerToPresent
  }
}

public enum PresentationStyle {
  case fullScreen
  case pageSheet
  case overCurrentContext
  case overFullScreen
  case custom
}
