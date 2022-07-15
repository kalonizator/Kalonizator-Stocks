import UIKit

public class SelfSizingTableView: UITableView {

  var minimumHeight: CGFloat = 0

  public override var contentSize: CGSize {
    didSet {
      invalidateIntrinsicContentSize()
      setNeedsLayout()
    }
  }

  public override var contentInset: UIEdgeInsets {
    didSet {
      invalidateIntrinsicContentSize()
      setNeedsLayout()
    }
  }

  public override var intrinsicContentSize: CGSize {
    var height = min(.infinity, contentSize.height + contentInset.top + contentInset.bottom)
    height = max(minimumHeight, height)
    return CGSize(width: contentSize.width, height: height)
  }

  public override func reloadData() {
    super.reloadData()
    invalidateIntrinsicContentSize()
    setNeedsLayout()
  }
}
