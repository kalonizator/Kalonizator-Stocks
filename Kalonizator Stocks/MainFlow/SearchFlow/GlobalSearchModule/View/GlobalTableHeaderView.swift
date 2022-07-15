import UIKit
import SnapKit

class GlobalTableHeaderView: UITableViewHeaderFooterView {

  private let titleLabel = UILabel(font: .regular20, numberOfLines: 1)

  enum SearchState {
    case lastResults
    case result
    case none
  }

  private var searchState: SearchState?

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    configureView()
    setupInitialLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  private func configureView() {
    titleLabel.textColor = .black
    titleLabel.setSemanticLeftTextAlignment()
  }

  private func setupInitialLayout() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.leading.trailing.centerY.equalToSuperview()
    }
  }

  private func setupTexts() {
    guard let searchState = searchState else {
      titleLabel.text?.removeAll()
      return
    }

    switch searchState {
    case .lastResults:
      titleLabel.text = "Last Requests"
    case .result:
      titleLabel.text = "Results"
    case .none:
      titleLabel.text?.removeAll()
    }
  }

  func setSearchState(searchState: SearchState?) {
    self.searchState = searchState
    setupTexts()
  }
}
