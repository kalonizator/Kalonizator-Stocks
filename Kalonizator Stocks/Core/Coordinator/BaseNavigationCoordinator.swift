import UIKit
import Swinject

open class BaseNavigationCoordinator: BaseNavigationController, BaseCoordinator {

  public var router: Routable { self }
  public let assembler: Assembler

  open func start() {
    fatalError("Implement 'start' method in \(self.self)")
  }

  open func handle(deepLink: DeepLink?) {}

  public init(assembler: Assembler) {
    self.assembler = assembler
    super.init(nibName: nil, bundle: nil)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
