import UIKit
import Swinject
import Alamofire

struct ServicesAssembly: Assembly {

  func assemble(container: Container) {
    registerConfigServices(in: container)
    registerNavigation(in: container)
    registerSessionManager(in: container)
    ApiServicesAssemblyImpl().registerNetworkLayer(in: container)
  }
}

private extension ServicesAssembly {

  func registerNavigation(in container: Container) {
    container.register(NavigationRouter.self) { _ in
      let navController = BaseNavigationController()
      return NavigationRouterImpl(rootController: navController)
    }.inObjectScope(.transient)

    container.register(TabBarModule.self) { _ in
      StocksTabBarController()
    }.inObjectScope(.transient)
  }

  func registerConfigServices(in container: Container) {
    container.register(ConfigService.self) { _ in
      ConfigServiceImpl()
    }.inObjectScope(.container)
  }

  func registerSessionManager(in container: Container) {
    container.register(Session.self) { resolver in
      return Session(startRequestsImmediately: false)
    }
    .inObjectScope(.container)
  }
}
