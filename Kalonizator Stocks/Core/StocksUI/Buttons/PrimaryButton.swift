import UIKit

final class PrimaryButton: UIButton {

  var normalBackgroundColor: UIColor = .black

  override var intrinsicContentSize: CGSize {
    .init(width: UIView.noIntrinsicMetric, height: 36)
  }

  override var isHighlighted: Bool {
    didSet {
      switch isHighlighted {
      case true:
        backgroundColor = UIColor.gray
      case false:
        backgroundColor = normalBackgroundColor
      }
    }
  }

  override var isEnabled: Bool {
    didSet {
      switch isEnabled {
      case true:
        backgroundColor = normalBackgroundColor
      case false:
        backgroundColor = UIColor.gray
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureView() {
    clipsToBounds = true
    layer.cornerRadius = 4
    titleLabel?.font = .regular16
    setTitleColor(.black, for: .normal)
    setTitleColor(.black, for: .disabled)
    backgroundColor = normalBackgroundColor
  }
}
