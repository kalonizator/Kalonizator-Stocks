import Swinject

struct MainPageCoordinatorAssembly: Assembly {

  func assemble(container: Container) {
    container.register(MainPageCoordinator.self) { (resolver, parentAssembler: Assembler) in
      let assembler = Assembler(
        [
          MainPageModuleAssembly(),
          GlobalSearchModuleAssembly(),
          StocksListServiceAssembly(),
          SocketServiceAssembly(),
          StocksDetailsModuleAssembly()
        ],
        parent: parentAssembler
      )
      let coordinator = MainPageCoordinatorImpl(
        assembler: assembler
      )
      return coordinator
    }
  }
}
