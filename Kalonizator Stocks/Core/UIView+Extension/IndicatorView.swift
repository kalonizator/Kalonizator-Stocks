import UIKit

final class IndicatorView: UIView {

  private let indictorLayer = CAShapeLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(indictorLayer)
    indictorLayer.fillColor = UIColor.clear.cgColor
    indictorLayer.lineWidth = Constants.lineWidth
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    let path = UIBezierPath(
      arcCenter: .init(x: frame.width / 2, y: frame.height / 2),
      radius: frame.height / 2 - Constants.lineWidth,
      startAngle: 0,
      endAngle: .pi * 4 / 3,
      clockwise: true
    )
    indictorLayer.path = path.cgPath
  }

  func set(color: UIColor) {
    indictorLayer.strokeColor = color.cgColor
  }
}

private extension IndicatorView {

  enum Constants {
    static let lineWidth: CGFloat = 3
  }
}
