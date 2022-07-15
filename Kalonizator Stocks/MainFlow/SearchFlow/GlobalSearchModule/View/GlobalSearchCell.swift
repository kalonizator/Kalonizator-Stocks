import UIKit
import SnapKit

class GlobalSearchCell: UITableViewCell {

  private let rightArrowImageView = UIImageView()
  private let searchTextLabel = UILabel(font: .regular16, numberOfLines: 1)
  private let groupLabel = UILabel(font: .regular16, numberOfLines: 1)

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureView()
    setupInitialLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureView() {
    contentView.backgroundColor = .white
    rightArrowImageView.image = Images.arrowRight.image
    rightArrowImageView.contentMode = .scaleAspectFit
    searchTextLabel.textColor = .black
    groupLabel.textColor = .gray
    searchTextLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    groupLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
  }

  private func setupInitialLayout() {
    let stackView = UIStackView(
      views: [searchTextLabel, groupLabel],
      axis: .horizontal,
      distribution: .fill,
      alignment: .fill,
      spacing: 8
    )

    contentView.addSubview(rightArrowImageView)
    rightArrowImageView.snp.makeConstraints { make in
      make.trailing.centerY.equalToSuperview()
      make.height.equalTo(Constants.arrowRightImageHeight)
      make.width.equalTo(Constants.arrowRightImageWidth)
    }

    contentView.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.leading.centerY.equalToSuperview()
      make.trailing.equalTo(rightArrowImageView.snp.leading).inset(-8)
    }
  }

  func set(searchText: String, groupName: String? = nil) {
    searchTextLabel.text = searchText
    groupLabel.text = groupName
    groupLabel.isHidden = true
  }
}

private extension GlobalSearchCell {
  enum Constants {
    static let arrowRightImageHeight = 24
    static let arrowRightImageWidth = 37
  }
}
