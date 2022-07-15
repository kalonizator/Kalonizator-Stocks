import UIKit

public enum Images: String {
  case search
  case close
  case arrowRight
  case coin
}

public extension Images {

  var image: UIImage? {
    UIImage(named: rawValue)
  }
}
