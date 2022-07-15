import UIKit

public final class PaginationTableFooterView: UIView {

  public let retryButton = UIButton()

  private let animationView = UIActivityIndicatorView()

  private let errorLabel: UILabel = {
    let label = UILabel()
    label.font = .regular14
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()

  public override var intrinsicContentSize: CGSize {
    return CGSize(width: UIView.noIntrinsicMetric, height: 60)
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
    setupTexts()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(state: PaginationState) {
    errorLabel.isHidden = !state.isError
    retryButton.isHidden = !state.isError
    animationView.isHidden = !state.isLoading
    if case let .error(error) = state {
      errorLabel.text = error.localizedDescription
    }
    if state.isLoading {
      animationView.startAnimating()
    } else {
      animationView.stopAnimating()
    }
  }

  private func setupTexts() {
    retryButton.setTitle("Retry", for: .normal)
  }

  private func setupInitialLayout() {
    addSubview(animationView)
    animationView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.size.equalTo(Constants.animationSize)
    }

    addSubview(errorLabel)
    errorLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalTo(snp.leadingMargin)
      make.trailing.equalTo(snp.trailingMargin)
    }

    addSubview(retryButton)
    retryButton.snp.makeConstraints { make in
      make.top.equalTo(errorLabel.snp.bottom)
      make.leading.equalTo(snp.leadingMargin)
      make.trailing.equalTo(snp.trailingMargin)
      make.bottom.equalToSuperview()
    }
  }
}

private extension PaginationTableFooterView {

  enum Constants {
    static let animationSize = 90
  }
}
