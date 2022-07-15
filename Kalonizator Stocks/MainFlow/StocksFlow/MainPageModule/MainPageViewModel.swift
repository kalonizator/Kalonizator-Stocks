import RxSwift

class MainPageViewModel: ViewModel {

  private var stocksInfo: [String: Trade] = [
    Constants.binance: Trade.init(
      p: nil,
      s: Constants.binance,
      t: nil,
      v: nil,
      oldPriceIsBigger: true
    ),
    Constants.apple: Trade.init(
      p: nil,
      s: Constants.apple,
      t: nil,
      v: nil,
      oldPriceIsBigger: true
    ),
    Constants.amazon: Trade.init(
      p: nil,
      s: Constants.amazon,
      t: nil,
      v: nil,
      oldPriceIsBigger: true
    ),
    Constants.icMarkets: Trade.init(
      p: nil,
      s: Constants.icMarkets,
      t: nil,
      v: nil,
      oldPriceIsBigger: true
    )
  ]

  private let apiService: ApiService
  private let stocksService: StocksListService

  init(apiService: ApiService, stocksService: StocksListService) {
    self.apiService = apiService
    self.stocksService = stocksService
  }

  struct Input {
    let getStocksList: Observable<Void>
  }

  struct Output {
    let stocksList: Observable<[Trade]>
    let error: Observable<StocksListServiceError>
  }

  func transform(input: Input) -> Output {
    stocksService.subscribe(
      symbols: [
        Constants.binance,
        Constants.apple,
        Constants.amazon,
        Constants.icMarkets
      ]
    )

    let stocksList = PublishSubject<[Trade]>()
    let stocksListError = PublishSubject<StocksListServiceError>()

    stocksService.receiveMessage { [unowned self] request in
      switch request {
      case .success(let result):
        switch result {
        case .trades(let trades):
          for trade in trades.data {
            var tempTrade = trade
            if self.stocksInfo[trade.s]?.s == tempTrade.s {
              let isPriceBiggerOrSame = (self.stocksInfo[trade.s]?.p ?? 0) == trade.p ?? 0
              tempTrade.oldPriceIsBigger = isPriceBiggerOrSame
              self.stocksInfo[trade.s] = tempTrade
              stocksList.onNext(self.getSortedStocksArray())
            }
          }
        case .news(_):
          break 
        case .ping(let ping):
          if ping.type != "ping" {
            stocksService.startConnection()
          }
        case .empty:
          break
        }
      case .failure(let error):
        stocksService.startConnection()
        stocksListError.onNext(error)
      }
    }
    return .init(
      stocksList: stocksList,
      error: stocksListError
    )
  }

  private func getSortedStocksArray() -> [Trade] {
    return stocksInfo.values.sorted(by: { $0.s > $1.s })
  }
}

private extension MainPageViewModel {
  enum Constants: CaseIterable {
    static let binance = "BINANCE:BTCUSDT"
    static let apple = "AAPL"
    static let amazon = "AMZN"
    static let icMarkets = "IC MARKETS:1"
  }
}
