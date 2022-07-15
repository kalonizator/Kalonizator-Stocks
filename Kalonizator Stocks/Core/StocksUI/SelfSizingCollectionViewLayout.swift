import UIKit

final class SelfSizingCollectionViewLayout: UICollectionViewFlowLayout {

  init(
    minimumLineSpacing: CGFloat = 0,
    minimumInteritemSpacing: CGFloat = 0
  ) {
    super.init()
    self.minimumLineSpacing = minimumLineSpacing
    self.minimumInteritemSpacing = minimumInteritemSpacing
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepare() {
    estimatedItemSize = UICollectionViewFlowLayout.automaticSize
  }
}
