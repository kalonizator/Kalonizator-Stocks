import UIKit

public protocol SearchImage where Self: UIViewController {

  var backgroundImageView: UIImageView { get }
  var blurEffectView: UIView { get }
}

open class SearchViewController: UIViewController, ViewHolder, SearchImage {

  public typealias RootViewType = SearchView

  public var backgroundImageView: UIImageView {
    rootView.backgroundImageView
  }

  public var blurEffectView: UIView {
    rootView.blurEffectView
  }

  private let transitionManager = SearchTransitionManager()

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    modalPresentationCapturesStatusBarAppearance = true
    transitioningDelegate = transitionManager
    modalPresentationStyle = .custom
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func loadView() {
    view = SearchView()
  }

  open override func viewDidLoad() {
    super.viewDidLoad()
    title = "Search"
    rootView.tableView.setSizedFooterView(rootView.tableFooterView)
    addDismissGesture()
  }

  private func addDismissGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSearch))
    tapGesture.delegate = self
    rootView.addGestureRecognizer(tapGesture)
  }

  @objc open func dismissSearch() {
    dismiss(animated: true)
  }
}

extension SearchViewController: UIGestureRecognizerDelegate {

  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    touch.view === gestureRecognizer.view
  }
}
