import UIKit
import Swinject
import IQKeyboardManagerSwift
import RxSwift

extension AppDelegate {

  func configureApp() {

    // Enable App logs
    enableLog()

    // Enable IQKeyboardManger
    configureKeyboard()

    AppearanceConfigurator.configure()
  }

  func makeCoordinator() -> Coordinator {
    let rootContainer = Container()
    rootContainer.register(AppRouter.self) { [unowned self] _ in
      return AppRouterImpl(window: self.window)
    }

    let assemblies: [Assembly] = [
      ServicesAssembly(),
      MainCoordinatorAssembly()
    ]

    let rootAssembler = Assembler(assemblies, container: rootContainer)
    let coordinator = rootAssembler.resolver.resolve(MainCoordinator.self, argument: rootAssembler)!
    return coordinator
  }

  private func configureKeyboard() {
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.enableAutoToolbar = false
    IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
    IQKeyboardManager.shared.shouldResignOnTouchOutside = true
  }

  private func enableLog() {
    #if DEBUG
    LoggerConfigurator.configure()
    #endif
  }
}
