import UIKit

final class LoadingIndicatorView: UIView {

  enum IndicatorStyle {
    case white
    case black
    case badge
  }

  private let indicatorView = IndicatorView()
  private let logoImageView = UIImageView(image: Images.coin.image?.withRenderingMode(.alwaysTemplate))

  init(style: IndicatorStyle) {
    super.init(frame: .zero)
    setupInitialLayout()
    logoImageView.contentMode = .scaleAspectFit
    switch style {
    case .black:
      indicatorView.set(color: .black)
    case .white:
      indicatorView.set(color: .white)
    case .badge:
      indicatorView.set(color: .black)
      logoImageView.isHidden = true
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupInitialLayout() {
    addSubview(indicatorView)
    indicatorView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.size.equalTo(Constants.indicatorSize)
      make.top.leading.greaterThanOrEqualToSuperview()
      make.trailing.bottom.lessThanOrEqualToSuperview()
    }

    addSubview(logoImageView)
    logoImageView.snp.makeConstraints { make in
      make.height.equalTo(Constants.logoHeight)
      make.top.leading.greaterThanOrEqualToSuperview()
      make.trailing.bottom.lessThanOrEqualToSuperview()
      make.center.equalToSuperview()
    }
  }

  func startAnimating() {
    indicatorView.rotate(duration: 0.8, clockwise: true)
  }

  func stopAnimating() {
    indicatorView.layer.removeAllAnimations()
  }
}

extension LoadingIndicatorView {

  enum Style {
    case black
    case white
  }
}

private extension LoadingIndicatorView {

  enum Constants {
    static let logoHeight = 15
    static let indicatorSize = 80
  }
}
