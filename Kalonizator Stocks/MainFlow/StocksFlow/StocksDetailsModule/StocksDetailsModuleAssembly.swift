import Swinject

struct StocksDetailsModuleAssembly: Assembly {

  func assemble(container: Container) {
    container.register(StocksDetailsModule.self) { (resolver, symbol: String) in
      let apiService = resolver.resolve(ApiService.self)!
      let configService = resolver.resolve(ConfigService.self)!
      let viewModel = StocksDetailsViewModel(
        symbol: symbol,
        apiService: apiService,
        configService: configService
      )
      let viewController = StocksDetailsViewController()
      viewController.viewModel = viewModel
      return viewController
    }
  }
}
