import RxSwift

class StocksDetailsViewModel: ViewModel {

  private let symbol: String
  private let apiService: ApiService
  private let configService: ConfigService

  init(
    symbol: String,
    apiService: ApiService,
    configService: ConfigService
  ) {
    self.symbol = symbol
    self.apiService = apiService
    self.configService = configService
  }

  struct Input {
    let loadDetails: Observable<Void>
  }

  struct Output {
    let details: Observable<LoadingSequence<StockDetails>>
  }

  func transform(input: Input) -> Output {
    let details = input.loadDetails
      .flatMap { [unowned self] in
        apiService.makeRequest(
          to: StocksTarget.companyDetails(
            symbol: symbol,
            token: configService.applicationApiToken
          )
        ).result(StockDetails.self).asLoadingSequence()
      }

    return .init(
      details: details.share()
    )
  }
}
