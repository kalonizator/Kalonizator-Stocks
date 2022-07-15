protocol GlobalSearchModule: Presentable {
  typealias SelectSearchTextCompletion = (SearchResultElement) -> Void

  var onSelectSearchTextCompletion: SelectSearchTextCompletion? { get set }
}
