import RxDataSources

struct GlobalSearchItemSection: SectionModelType {
  typealias Item = String

  var items: [String]

  let title: String

  init(items: [String], title: String) {
    self.items = items
    self.title = title
  }

  init(original: GlobalSearchItemSection, items: [String]) {
    self = original
    self.items = items
  }
}
