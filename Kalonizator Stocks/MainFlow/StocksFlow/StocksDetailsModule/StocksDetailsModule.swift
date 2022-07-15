protocol StocksDetailsModule: Presentable {
  typealias GoBack = () -> Void

  var onGoBack: GoBack? { get set }
}
