import Swinject

struct GlobalSearchActionModuleAssembly: Assembly {

  func assemble(container: Container) {
    container.register(GlobalSearchActionModule.self) { _ in
      let view = GlobalSearchActionView()
      return view
    }
  }
}
