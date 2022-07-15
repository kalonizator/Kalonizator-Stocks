import UIKit

public class StocksTabBarController: UITabBarController, TabBarModule {

  public override var navigationBarHidden: Bool { true }

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    tabBar.tintColor = .black
    tabBar.unselectedItemTintColor = .gray
    tabBar.isTranslucent = false
    tabBar.backgroundColor = .gray
    tabBar.barTintColor = .gray
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open func setTabs(_ tabs: [Presentable?]) {
    setViewControllers(tabs.compactMap { $0?.toPresent() }, animated: false)
  }

  open func selectTab(_ tab: Presentable?) {
    guard let controller = tab?.toPresent() else { return }
    guard let indexToSelect = viewControllers?.firstIndex(where: { $0 == controller }) else { return }

    selectedIndex = indexToSelect
  }
}
