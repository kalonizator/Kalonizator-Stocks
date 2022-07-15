import RxDataSources

class GlobalSearchDataSource: RxTableViewSectionedReloadDataSource<GlobalSearchItemSection> {

  init() {
    super.init(configureCell: { _, tableView, indexPath, item in
      let cell: GlobalSearchCell = tableView.dequeueReusableCell(for: indexPath)
      cell.set(searchText: item)
      return cell
    }
    )
  }
}
