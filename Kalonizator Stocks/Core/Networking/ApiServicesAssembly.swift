import Foundation
import Alamofire
import Swinject

public protocol ApiServicesAssembly {
  func registerNetworkLayer(in container: Container)
}

public struct ApiServicesAssemblyImpl: ApiServicesAssembly {

  public init() {}

  public func registerNetworkLayer(in container: Container) {
    container.register(StocksRequestAdapter.self) { resolver in
      let configService = resolver.resolve(ConfigService.self)!
      return StocksRequestAdapter(configService: configService)
    }

    container.register(StocksRequestRetrier.self) { resolver in
      let retrier = StocksRequestRetrierImpl()
      return retrier
    }

    container.register(RequestInterceptor.self) { resolver in
      let adapter = resolver.resolve(StocksRequestAdapter.self)!
      let retrier = resolver.resolve(StocksRequestRetrier.self)!
      return Interceptor(adapter: adapter, retrier: retrier)
    }

    container.register(ApiRequestable.self) { (resolver, target: ApiTarget, stubbed: Bool, baseUrl: URL) in
      if stubbed {
        return StubApiRequest(target: target, behaviour: .afterDelay(1))
      } else {
        let sessionManager = resolver.resolve(Session.self)!
        let configService = resolver.resolve(ConfigService.self)!
        let interceptor = resolver.resolve(RequestInterceptor.self)!

        return ApiRequest(url: baseUrl, target: target, manager: sessionManager, interceptor: interceptor)
      }
    }
    .inObjectScope(.transient)

    container.register(ApiService.self) { resolver in
      let sessionManager = resolver.resolve(Session.self)!
      let configService = resolver.resolve(ConfigService.self)!
      return ApiServiceImpl(sessionManager: sessionManager) { target, stubbed in
        return resolver.resolve(ApiRequestable.self, arguments: target, stubbed, configService.apiUrl)!
      }
    }
    .inObjectScope(.container)

    container.register(ApiService.self) { (resolver, baseUrl: URL) in
      let sessionManager = resolver.resolve(Session.self)!
      return ApiServiceImpl(sessionManager: sessionManager) { target, stubbed in
        return resolver.resolve(ApiRequestable.self, arguments: target, stubbed, baseUrl)!
      }
    }
    .inObjectScope(.container)
  }
}
