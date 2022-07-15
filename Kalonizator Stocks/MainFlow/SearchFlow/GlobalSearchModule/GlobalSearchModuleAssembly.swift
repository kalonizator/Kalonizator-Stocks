import Swinject

struct GlobalSearchModuleAssembly: Assembly {

  func assemble(container: Container) {
    container.register(GlobalSearchModule.self) { resolver in
      let apiService = resolver.resolve(ApiService.self)!
      let configService = resolver.resolve(ConfigService.self)!
      let viewModel = GlobalSearchViewModel(
        apiService: apiService,
        configService: configService
      )
      let viewController = GlobalSearchViewController()
      viewController.viewModel = viewModel
      return viewController
    }
  }
}
