public protocol Coordinator: AnyObject, Presentable {

  var router: Routable { get }

  func start()
  func handle(deepLink: DeepLink?)
}

public protocol DeepLink {}
