protocol MainPageModule: Presentable, BarButtonContainerModule {
  typealias ShowCompanyDetail = (String) -> Void

  var onShowCompanyDetail: ShowCompanyDetail? { get set }
}
