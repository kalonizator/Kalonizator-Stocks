import UIKit
import SwiftUI

class ContactsView: UIView {

  let tableView = UITableView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureView() {
    backgroundColor = .white
    tableView.backgroundColor = .white
    tableView.translatesAutoresizingMaskIntoConstraints = false
  }

  func setupLayout() {
    addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
    ])
  }
}
