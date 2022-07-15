import UIKit

public protocol TabBarModule: Presentable {

  typealias Completion = () -> Void

  func setTabs(_ tabs: [Presentable?])
  func selectTab(_ tab: Presentable?)
}
