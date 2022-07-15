import UIKit

class MainPageView: UIView {

  let tableView = SelfSizingTableView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
    setupInitialLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureView() {
    backgroundColor = .white
  }

  private func setupInitialLayout() {
    let stackView = UIStackView(
      views: [tableView],
      axis: .vertical,
      distribution: .fill,
      alignment: .fill,
      spacing: 20
    )
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
