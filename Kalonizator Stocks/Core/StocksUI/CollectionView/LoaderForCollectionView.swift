import UIKit

public final class LoaderForCollectionView: UICollectionReusableView {

  private let animationView = LoadingIndicatorView(style: .black)

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
    animationView.startAnimating()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupInitialLayout() {
    addSubview(animationView)
    animationView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.top.bottom.equalToSuperview().inset(16)
      make.size.equalTo(Constants.animationSize)
    }
  }
}

private extension LoaderForCollectionView {

  enum Constants {
    static let animationSize: CGFloat = 80
  }
}
