import Foundation
import UIKit

protocol MainCoordinator: Coordinator {}

final class MainCoordinatorImpl: BaseViewCoordinator, MainCoordinator {

  private var history: [Coordinator?] = []

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    /// Removing oldest coordinator from history, because of user did not use it for a long time
    if !history.isEmpty {
      history.removeFirst()
    }
  }

  private var tabModule: TabBarModule?

  override func start() {
    runMainFlow()
  }

  // MARK: - Deeplink handle

  private func dismissIfNeeded(in router: Routable, completion: @escaping () -> Void) {
    guard router.toPresent()?.presentedViewController != nil else {
      completion()
      return
    }

    router.dismissModule(animated: true) {
      completion()
    }
  }

  lazy var mainPageCoordinator = createMainPage()

  private func runMainFlow() {
    tabModule = assembler.resolver.resolve(TabBarModule.self)
    tabModule?.setTabs([
      mainPageCoordinator.router
    ])
    router.setRootModule(tabModule)
  }

  @discardableResult
  private func createMainPage() -> Coordinator {
    let coordinator = assembler.resolver.resolve(MainPageCoordinator.self, argument: assembler)!
    startAndPresent(coordinator: coordinator)
    return coordinator
  }
}

// MARK: - History
extension MainCoordinatorImpl {

  private func startAndPresent(coordinator: Coordinator) {
    startCoordinatorIfNotInHistory(coordinator)
  }

  private func addToHistory(coordinator: Coordinator?) {
    history.removeAll(where: { $0 === coordinator })
    history.append(coordinator)
  }

  private func startCoordinatorIfNotInHistory(_ coordinator: Coordinator) {
    if !history.contains(where: { $0 === coordinator }) {
      coordinator.start()
    }
    addToHistory(coordinator: coordinator)
  }
}
