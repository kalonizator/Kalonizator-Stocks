import UIKit

public enum AppearanceConfigurator {
  static public func configure() {
    UINavigationBar.appearance().isTranslucent = false

    UINavigationBar.appearance().prefersLargeTitles = false

    UITableView.appearance().separatorInset = .zero

    UILabel.appearance().isOpaque = true
  }
}
