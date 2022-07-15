import UIKit

public final class ErrorView: UIView {

  private let titleLabel: UILabel = {
    let label = UILabel(font: .regular20)
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    label.textColor = .black
    return label
  }()

  private let descriptionLabel: UILabel = {
    let label = UILabel(font: .regular14)
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    label.textColor = .black
    return label
  }()

  private let retryButton: UIButton = PrimaryButton()

  private let retryAction: (() -> Void)?

  public init(
    error: Error,
    retryAction: (() -> Void)? = nil
  ) {
    self.retryAction = retryAction

    super.init(frame: .zero)

    if retryAction == nil {
      retryButton.isHidden = true
    } else {
      retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
    }
    setupInitialLayout()
    setupTexts()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupInitialLayout() {
    let contentStackView = UIStackView(
      views: [titleLabel, descriptionLabel, retryButton],
      axis: .vertical,
      alignment: .center,
      spacing: 8
    )
    contentStackView.setCustomSpacing(32, after: descriptionLabel)

    addSubview(contentStackView)
    contentStackView.snp.makeConstraints { make in
      make.top.leading.greaterThanOrEqualToSuperview()
      make.trailing.bottom.lessThanOrEqualToSuperview()
      make.center.equalToSuperview()
    }

    retryButton.snp.makeConstraints { make in
      make.height.equalTo(Constants.buttonHeight)
      make.width.equalTo(Constants.buttonWidth)
    }
  }

  private func setupTexts() {
    titleLabel.text = "Loading Error"
    descriptionLabel.text = "Something went wrong, try again"
    retryButton.setTitle("Repeat", for: .normal)
  }

  @objc private func retry() {
    retryAction?()
  }
}

private extension ErrorView {

  enum Constants {
    static let buttonHeight = 32
    static let buttonWidth = 164
  }
}
