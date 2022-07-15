import UIKit
import RxSwift

class GlobalSearchViewController: UIViewController, GlobalSearchModule, ViewHolder {

  typealias RootViewType = GlobalSearchView

  var onSelectSearchTextCompletion: SelectSearchTextCompletion?

  var viewModel: GlobalSearchViewModel!

  private let disposeBag = DisposeBag()

  override func loadView() {
    view = GlobalSearchView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Search"
    configureView()
    bindViewModel()
    bindView()
  }

  private func configureView() {
    rootView.tableView.registerClassForCell(GlobalSearchCell.self)
    rootView.tableView.estimatedRowHeight = 51
    rootView.tableView.rowHeight = 51
  }

  private func bindView() {
    rootView.tableView.rx.modelSelected(SearchResultElement.self)
      .subscribe(onNext: { [unowned self] result in
        self.onSelectSearchTextCompletion?(result)
      })
      .disposed(by: disposeBag)

    rootView.tableView.rx.itemSelected
      .bind { [unowned self] indexPath in
        self.rootView.tableView.deselectRow(at: indexPath, animated: true)
      }
      .disposed(by: disposeBag)
  }

  private func bindViewModel() {
    let output = viewModel.transform(
      input: .init(
        searchText: rootView.searchBar.rx.text.unwrap()
      )
    )

    output.searchResult.loading
      .bind { [unowned self] isLoading in
        self.rootView.loaderView.rx.loading.onNext(isLoading)
        self.rootView.loaderView.rx.isHidden.onNext(!isLoading)
      }
      .disposed(by: disposeBag)

    output.searchResult.errors
      .bind(to: rootView.loaderView.rx.error)
      .disposed(by: disposeBag)

    output.searchResult.element
      .bind { [unowned self] searchTextArray in
        self.rootView.setSearchState(searchState: .result)
      }
      .disposed(by: disposeBag)

    output.searchResult.element
      .bind(to: rootView.tableView.rx.items(GlobalSearchCell.self)) { _, model, cell in
        cell.set(searchText: model.displaySymbol ?? "")
      }
      .disposed(by: disposeBag)

    output.searchResult.connect()
      .disposed(by: disposeBag)
  }
}
