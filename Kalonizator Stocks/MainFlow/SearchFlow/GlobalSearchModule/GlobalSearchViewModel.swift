import RxSwift

final class GlobalSearchViewModel: ViewModel {

  private let apiService: ApiService
  private let configService: ConfigService

  init(apiService: ApiService, configService: ConfigService) {
    self.apiService = apiService
    self.configService = configService
  }

  struct Input {
    let searchText: Observable<String>
  }

  struct Output {
    let searchResult: ConnectableObservable<LoadingSequence<[SearchResultElement]>>
  }

  func transform(input: Input) -> Output {

    let searchResult = input.searchText
      .debounce(
        .milliseconds(750),
        scheduler: MainScheduler.instance
      )
      .flatMap { [unowned self] text in
        return self.apiService.makeRequest(
          to: StocksTarget.search(
            text: text,
            token: configService.applicationApiToken
          )
        )
          .result(SearchResultModel.self).map({ $0.result })
          .asLoadingSequence()
      }

    return .init(searchResult: searchResult.share().publish())
  }
}
