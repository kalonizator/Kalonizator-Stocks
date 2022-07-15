import Swinject

struct MainCoordinatorAssembly: Assembly {

  func assemble(container: Container) {
    container.register(MainCoordinator.self) { (resolver, parentAssembler: Assembler) in
      let assembler = Assembler(
        [
         MainPageCoordinatorAssembly(),
         GlobalSearchModuleAssembly(),
         GlobalSearchActionModuleAssembly()
        ],
        parent: parentAssembler
      )
      return MainCoordinatorImpl(assembler: assembler, router: resolver.resolve(AppRouter.self)!)
    }
  }
}
