protocol MainPageCoordinator: Coordinator {}

final class MainPageCoordinatorImpl: BaseNavigationCoordinator, MainPageCoordinator, GlobalSearchCoordinator {

  override func start() {
    showRootModule()
  }

  private func showRootModule() {
    var module = assembler.resolver.resolve(MainPageModule.self)!
    module.addRightBarButton(module: createSearchPreview())
    module.onShowCompanyDetail = { [weak self] symbol in
      self?.showDetails(symbol: symbol)
    }
    router.setRootModule(module)
  }

  private func showDetails(symbol: String) {
    var module = assembler.resolver.resolve(StocksDetailsModule.self, argument: symbol)!
    module.onGoBack = { [weak self] in
      self?.router.popModule()
    }
    router.push(module)
  }
}
