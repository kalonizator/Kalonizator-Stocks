import UIKit

final class CollectionViewWithHeaderFooter: UICollectionView {

  var collectionHeaderView: UIView? {
    willSet {
      collectionHeaderView?.removeFromSuperview()
    }
    didSet {
      contentInset.top = 0
      guard let collectionHeaderView = collectionHeaderView else { return }
      addSubview(collectionHeaderView)
      headerSizeObserver = collectionHeaderView.observe(
        \.frame,
        options: [.initial, .new]
      ) { [weak self] _, change in
        guard
          let headerSize = change.newValue?.size,
          collectionHeaderView.frame.size != headerSize
        else { return }
        self?.updateHeader(size: headerSize)
      }
    }
  }

  var collectionFooterView: UIView? {
    willSet {
      collectionFooterView?.removeFromSuperview()
    }
    didSet {
      guard let collectionFooterView = collectionFooterView else { return }
      addSubview(collectionFooterView)
      footerSizeObserver = collectionFooterView.observe(
        \.frame,
        options: [.initial, .new]
      ) { [weak self] _, change in
        guard
          let footerSize = change.newValue?.size,
          collectionFooterView.frame.size != footerSize
        else { return }
        self?.updateFooter(size: footerSize)
      }
    }
  }

  override var contentSize: CGSize {
    didSet {
      updateFooterPosition()
    }
  }

  private var headerSizeObserver: Any?
  private var footerSizeObserver: Any?

  override func layoutSubviews() {
    super.layoutSubviews()
    calculateHeaderFrameIfNeeded()
    calculateFooterFrameIfNeeded()
  }

  private func calculateHeaderFrameIfNeeded() {
    guard
      let collectionHeaderView = collectionHeaderView,
      frame.width != collectionHeaderView.frame.width
    else {
      return
    }

    let fitSize = CGSize(width: frame.width, height: UIView.layoutFittingCompressedSize.height)

    let headerSize = collectionHeaderView.systemLayoutSizeFitting(
      fitSize,
      withHorizontalFittingPriority: .defaultHigh,
      verticalFittingPriority: .defaultLow
    )
    updateHeader(size: headerSize)
  }

  private func calculateFooterFrameIfNeeded() {
    guard
      let collectionFooterView = collectionFooterView,
      frame.width != collectionFooterView.frame.width
    else {
      return
    }

    let fitSize = CGSize(width: frame.width, height: UIView.layoutFittingCompressedSize.height)

    let footerSize = collectionFooterView.systemLayoutSizeFitting(
      fitSize,
      withHorizontalFittingPriority: .defaultHigh,
      verticalFittingPriority: .defaultLow
    )
    updateFooter(size: footerSize)
    updateFooterPosition()
  }

  private func updateHeader(size: CGSize) {
    collectionHeaderView?.frame.size = size
    collectionHeaderView?.frame.origin.y = -size.height
    contentInset.top = size.height
  }

  private func updateFooter(size: CGSize) {
    collectionFooterView?.frame.size = size
    collectionFooterView?.frame.origin.y = contentSize.height
    contentInset.bottom = size.height
  }

  private func updateFooterPosition() {
    collectionFooterView?.frame.origin.y = contentSize.height
  }
}
