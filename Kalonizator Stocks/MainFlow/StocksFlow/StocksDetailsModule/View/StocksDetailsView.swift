import UIKit

class StocksDetailsView: UIView {

  private let companyNameLabel = UILabel(font: .regular20, numberOfLines: 1)
  private let symbolLabel = UILabel(font: .regular20, numberOfLines: 1)
  private let industryLabel = UILabel(font: .regular14, numberOfLines: 1)
  private let priceLabel = UILabel(font: .regular14, numberOfLines: 1)

  private let logoImageView = LoaderImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
    setupInitialLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureView() {
    backgroundColor = .white
    for label in [
      companyNameLabel,
      symbolLabel,
      industryLabel,
      priceLabel
    ] {
      label.textColor = .black
    }
    logoImageView.contentMode = .scaleAspectFit
  }

  private func setupInitialLayout() {
    let stackView = UIStackView(
      views: [
        companyNameLabel,
        symbolLabel,
        logoImageView,
        industryLabel,
        priceLabel
      ],
      axis: .vertical,
      distribution: .fill,
      alignment: .top,
      spacing: 8
    )

    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview().inset(16)
    }

    logoImageView.snp.makeConstraints({ $0.size.equalTo(50) })
  }

  func set(imageUrl: String?) {
    logoImageView.setImage(with: imageUrl)
  }

  func set(
    name: String?,
    symbol: String?,
    industry: String?,
    price: Double?
  ) {
    companyNameLabel.text = name
    symbolLabel.text = symbol
    industryLabel.text = industry
    guard let price = price else { return }
    priceLabel.text = String(price)
  }
}
