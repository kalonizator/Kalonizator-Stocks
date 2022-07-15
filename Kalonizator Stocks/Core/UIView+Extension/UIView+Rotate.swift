import UIKit

public extension UIView {

  func rotate(duration: Double = 1, clockwise: Bool) {
    let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotation.toValue = CGFloat.pi * 2 * (clockwise ? 1 : -1)
    rotation.duration = duration
    rotation.isCumulative = true
    rotation.repeatCount = Float.greatestFiniteMagnitude
    rotation.isRemovedOnCompletion = false
    self.layer.add(rotation, forKey: "rotationAnimation")
  }
}
