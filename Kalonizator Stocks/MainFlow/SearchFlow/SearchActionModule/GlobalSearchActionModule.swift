protocol GlobalSearchActionModule: ToBarButtonItemConvertable {
  typealias Completion = () -> Void

  var onTap: Completion? { get set }
}
