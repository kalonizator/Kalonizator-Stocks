import Swinject
import Foundation

struct StocksListServiceAssembly: Assembly {

  func assemble(container: Container) {
    container.register(StocksListService.self) { (resolver, url: URL) in
      let socketService = resolver.resolve(SocketService.self, argument: url)!
      let client = StocksListServiceImpl(socketService: socketService)
      return client
    }
  }
}
