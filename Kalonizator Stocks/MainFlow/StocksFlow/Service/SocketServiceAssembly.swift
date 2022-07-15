import Swinject
import Foundation

struct SocketServiceAssembly: Assembly {

  func assemble(container: Container) {
    container.register(SocketService.self) { (resolver, url: URL) in
      let service = SocketServiceImpl(url: url)
      return service
    }
  }
}
