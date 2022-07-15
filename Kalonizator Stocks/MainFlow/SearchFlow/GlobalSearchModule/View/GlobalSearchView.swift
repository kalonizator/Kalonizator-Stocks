import UIKit

class GlobalSearchView: UIView {

  let loaderView = UIView()

  let searchBar: SearchBar = {
    let searchBar = SearchBar()
    searchBar.cornerRadius = 4
    return searchBar
  }()

  let titleLabel = UILabel(font: .regular20, numberOfLines: 1)

  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.showsVerticalScrollIndicator = false
    tableView.keyboardDismissMode = .onDrag
    return tableView
  }()

  enum SearchState {
    case lastResults
    case result
    case none
  }

  private var searchState: SearchState?

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
    setupInitialLayout()
    setupTexts()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupTexts() {
    searchBar.placeholder = "Search"
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
      titleLabel.isHidden = true
    }
  }

  private func configureView() {
    backgroundColor = .white
    tableView.backgroundColor = .white
    titleLabel.textColor = .black
    titleLabel.setSemanticLeftTextAlignment()
    loaderView.isHidden = true
    loaderView.backgroundColor = .white
  }

  private func setupInitialLayout() {
    let stackView = UIStackView(
      views: [searchBar, titleLabel, tableView],
      axis: .vertical,
      spacing: 24
    )

    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.top.bottom.equalTo(safeAreaLayoutGuide).inset(16)
    }

    addSubview(loaderView)
    loaderView.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide).inset(searchBar.frame.height)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(safeAreaLayoutGuide)
    }
  }

  func setSearchState(searchState: SearchState?) {
    self.searchState = searchState
    setupTexts()
  }
}
