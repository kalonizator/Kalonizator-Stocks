protocol GlobalSearchCoordinator: Coordinator {}

extension GlobalSearchCoordinator where Self:
BaseCoordinator {

  func createSearchPreview() -> ToBarButtonItemConvertable {
    var module = assembler.resolver.resolve(GlobalSearchActionModule.self)!
    module.onTap = { [weak self] in
      self?.showGlobalSearch()
    }
    return module
  }

  func showGlobalSearch() {
    var module = assembler.resolver.resolve(GlobalSearchModule.self)!
    // Did not completed
    module.onSelectSearchTextCompletion = { [weak self] searchQuery in
      
    }
    router.push(module)
  }
}
