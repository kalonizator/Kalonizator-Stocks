import UIKit
import SnapKit

public final class EmptyView: UIView {

  private let titleLabel = UILabel(font: .regular20)
  private let descriptionLabel = UILabel(font: .regular14)

  private let moveButton = PrimaryButton()

  private var moveAction: (() -> Void)?

  public init(
    title: String?,
    subtitle: String?,
    buttonTitle: String? = nil,
    moveAction: (() -> Void)? = nil
  ) {
    self.moveAction = moveAction
    super.init(frame: .init())
    set(buttonTitle: buttonTitle, moveAction: moveAction)
    set(title: title, subtitle: subtitle)
    configureView()
    setupInitialLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc private func retry() {
    moveAction?()
  }

  private func configureView() {
    titleLabel.textColor = .black
    descriptionLabel.textColor = .gray
    titleLabel.textAlignment = .center
    descriptionLabel.textAlignment = .center
  }

  private func setupInitialLayout() {
    let contentView = UIStackView(
      views: [titleLabel, descriptionLabel, moveButton],
      axis: .vertical,
      alignment: .center,
      spacing: 8
    )
    contentView.setCustomSpacing(32, after: descriptionLabel)
    addSubview(contentView)
    contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }

  public func set(title: String? = nil, subtitle: String? = nil) {
    titleLabel.text = title
    descriptionLabel.text = subtitle
  }

  public func set(buttonTitle: String?, moveAction: (() -> Void)?) {
    moveButton.setTitle(buttonTitle, for: .normal)
    self.moveAction = moveAction
    moveButton.isHidden = moveAction == nil
    moveButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
  }
}
