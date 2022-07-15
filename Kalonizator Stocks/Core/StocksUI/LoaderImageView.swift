import UIKit
import Kingfisher

open class LoaderImageView: UIImageView {

  private var placeholder: UIImage?
  private var imageUrl: URL?

  public override init(image: UIImage?) {
    super.init(image: image)
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
  }

  public init(placeholder: UIImage? = nil) {
    self.placeholder = placeholder
    super.init(frame: .zero)
    self.kf.indicatorType = .activity
    self.configureKingFisher()
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureKingFisher() {
    // Cache lifetime 2 years
    ImageCache.default.memoryStorage.config.expiration = .days(Constants.cacheDaysLifeTime)
    ImageCache.default.diskStorage.config.expiration = .days(Constants.cacheDaysLifeTime)
    // Size limit is 100 MB
    ImageCache.default.memoryStorage.config.totalCostLimit = Int(Constants.memorySizeLimit)
    ImageCache.default.diskStorage.config.sizeLimit = Constants.memorySizeLimit
  }

  public func prepareForReuse() {
    kf.cancelDownloadTask()
    if placeholder != nil {
      if imageUrl == nil {
        image = placeholder
      }
    } else {
      image = nil
    }
  }

  public func setImage(with urlString: String?) {
    guard let url = URL(string: urlString ?? "") else { return }
    setImage(with: url)
  }

  public func setImage(with url: URL?) {
    if let url = url {
      imageUrl = url
      kf.setImage(with: url, placeholder: placeholder, options: [
        .transition(.fade(0.25))
      ])
    } else {
      image = placeholder
    }
  }

  public func set(placeholder: UIImage?) {
    if imageUrl == nil || image == self.placeholder {
      image = placeholder
    }
    self.placeholder = placeholder
  }
}

extension LoaderImageView {
  func setVisibillityImageUrl(_ imageUrl: String?) {
    isHidden = imageUrl == nil
    setImage(with: imageUrl)
  }
}

extension LoaderImageView {
  enum Constants {
    static let cacheDaysLifeTime: Int = 700
    static let memorySizeLimit: UInt = 100 * 1024 * 5024
  }
}
