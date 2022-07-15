import UIKit
import RxSwift

class MainPageViewController: UIViewController, ViewHolder, MainPageModule {

  typealias RootViewType = MainPageView

  var onShowCompanyDetail: ShowCompanyDetail?

  var viewModel: MainPageViewModel!

  private let loadRequestSubject = PublishSubject<Void>()

  private let disposeBag = DisposeBag()

  override func loadView() {
    view = MainPageView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    registerCell()
    bindViewModel()
    bindView()
  }

  private func registerCell() {
    rootView.tableView.registerClassForCell(StockCell.self)
  }

  private func bindView() {
    rootView.tableView.rx.modelSelected(Trade.self)
      .subscribe(onNext: { [unowned self] model in
        self.onShowCompanyDetail?(model.s)
      })
      .disposed(by: disposeBag)
  }

  private func bindViewModel() {
    let output = viewModel.transform(
      input: .init(
        getStocksList: Observable.merge(
          .just(()),
          rootView.rx.retryAction,
          loadRequestSubject
        )
      )
    )

    output.stocksList
      .bind(to: rootView.tableView.rx.items(StockCell.self)) { _, model, cell in
        cell.set(trade: model)
      }
      .disposed(by: disposeBag)

    output.error
      .bind { [unowned self] error in
        self.showErrorInAlert(error) {
          loadRequestSubject.onNext(())
        }
      }
      .disposed(by: disposeBag)
  }
}
