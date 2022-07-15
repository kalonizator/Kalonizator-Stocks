import UIKit
import RxSwift

final class GlobalSearchActionView: UIControl {

  var onTap: Completion?

  private let disposeBag = DisposeBag()

  private let imageIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()

  init() {
    super.init(frame: .zero)

    setupInitialLayout()
    configureView()
    addTarget(self, action: #selector(didTap), for: .touchUpInside)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = Constants.size / 2
    imageIcon.layer.cornerRadius = imageIcon.bounds.width / 2
    addShadow()
  }

  private func addShadow() {
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.shadowOpacity = 0.1
    layer.shadowRadius = 2
  }

  private func setupInitialLayout() {
    snp.makeConstraints { $0.size.equalTo(Constants.size) }

    addSubview(imageIcon)
    imageIcon.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.edges.equalToSuperview().inset(8)
    }
  }

  private func configureView() {
    imageIcon.image = Images.search.image?.withTintColor(.black)
  }

  @objc private func didTap() {
    self.onTap?()
  }
}

private extension GlobalSearchActionView {

  enum Constants {
    static let size: CGFloat = 30
  }
}

extension GlobalSearchActionView: GlobalSearchActionModule {
  var barButtonItem: UIBarButtonItem {
    UIBarButtonItem(customView: self)
  }
}
