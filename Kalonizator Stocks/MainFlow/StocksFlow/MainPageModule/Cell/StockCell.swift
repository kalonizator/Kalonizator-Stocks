import UIKit
import RxSwift

class StockCell: UITableViewCell {

  var oldPrice: Float?

  private let titleLabel = UILabel(font: .regular14, numberOfLines: 1)
  private let priceLabel = UILabel(font: .regular14, numberOfLines: 1)

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureView()
    setupInitialLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text?.removeAll()
    oldPrice = nil
  }

  private func configureView() {
    titleLabel.textColor = .black
    priceLabel.textColor = .black
    priceLabel.text = "Loading..."
  }

  private func setupInitialLayout() {
    let stackView = UIStackView(
      views: [titleLabel, UIView(), priceLabel],
      distribution: .equalSpacing,
      alignment: .fill
    )
    contentView.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(4)
    }
  }

  func set(trade: Trade) {
    titleLabel.text = trade.s
    guard let price = trade.p else { return }
    priceLabel.text = String(price)
    priceLabel.textColor = trade.oldPriceIsBigger ? .green : .red
  }
}
