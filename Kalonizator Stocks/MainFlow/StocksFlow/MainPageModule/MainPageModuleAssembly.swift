import Swinject

struct MainPageModuleAssembly: Assembly {

  func assemble(container: Container) {
    container.register(MainPageModule.self) { resolver in
      let apiService = resolver.resolve(ApiService.self)!
      let configService = resolver.resolve(ConfigService.self)!
      let stocksService = resolver.resolve(
        StocksListService.self,
        argument: configService.socketSdkUrl
      )!
      let viewModel = MainPageViewModel(apiService: apiService, stocksService: stocksService)
      let viewController = MainPageViewController()
      viewController.viewModel = viewModel
      return viewController
    }
  }
}
