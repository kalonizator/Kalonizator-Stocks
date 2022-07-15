import UIKit

public class SearchBar: UISearchBar {

  public override var intrinsicContentSize: CGSize {
    .init(width: UIView.noIntrinsicMetric, height: 48)
  }

  public var cornerRadius: CGFloat?

  public override init(frame: CGRect) {
    super.init(frame: frame)
    barStyle = .default
    searchBarStyle = .prominent
    backgroundImage = UIImage()
    backgroundColor = .gray
    setImage(Images.search.image?.withRenderingMode(.alwaysOriginal), for: .search, state: .normal)
    setImage(Images.close.image?.withRenderingMode(.alwaysOriginal), for: .clear, state: .normal)
    clipsToBounds = true
    textField?.clearButtonMode = .always
    textField?.backgroundColor = .clear
    textField?.textColor = .black
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    textField?.frame = bounds
  }
}
