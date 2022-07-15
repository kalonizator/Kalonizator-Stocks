import UIKit
import RxSwift

class StoctListElementCell: UITableViewCell {

  var disposeBag = DisposeBag()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = DisposeBag()
  }

  private func configureView() {

  }

  private func setupInitialLayout() {

  }

}
