import UIKit
import RxSwift

class StocksDetailsViewController: UIViewController, ViewHolder, StocksDetailsModule {

  typealias RootViewType = StocksDetailsView

  var onGoBack: GoBack?

  var viewModel: StocksDetailsViewModel!

  private let disposeBag = DisposeBag()

  override func loadView() {
    view = StocksDetailsView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
  }

  private func bindViewModel() {
    let output = viewModel.transform(
      input: .init(
        loadDetails: Observable.merge(
          Observable.just(()),
          rootView.rx.retryAction
        )
      )
    )

    output.details.loading
      .bind(to: rootView.rx.loading)
      .disposed(by: disposeBag)

    output.details.errors
      .bind(to: rootView.rx.error)
      .disposed(by: disposeBag)

    output.details.element
      .bind { [unowned self] details in
        if details.isEmpty {
          rootView.showEmpty(
            "No data :(",
            subtitle: "Check another ticker",
            buttonTitle: "Go Back"
          ) {
            onGoBack?()
          }
        } else {
          self.rootView.set(imageUrl: details.logo)
          self.rootView.set(
            name: details.name,
            symbol: details.ticker,
            industry: details.finnhubIndustry,
            price: details.shareOutstanding
          )
        }
      }
      .disposed(by: disposeBag)
  }
}
