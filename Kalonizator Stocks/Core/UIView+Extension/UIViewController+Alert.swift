import UIKit

public extension UIViewController {

  func showSimpleAlert(title: String?, message: String?, action: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
    present(alertController, animated: true, completion: action)
  }

  func showErrorInAlert(_ error: Error) {
    let controller = UIAlertController(
      title: "Error",
      message: error.localizedDescription,
      preferredStyle: .alert
    )
    let action = UIAlertAction(title: "Dismiss", style: .cancel) { _ in
      controller.dismiss(animated: true, completion: nil)
    }
    controller.addAction(action)

    present(controller, animated: true, completion: nil)
  }

  func showErrorInAlert(text: String) {
    let controller = UIAlertController(
      title: "Error",
      message: text,
      preferredStyle: .alert
    )
    let action = UIAlertAction(title: "Dismiss", style: .cancel) { _ in
      controller.dismiss(animated: true, completion: nil)
    }
    controller.addAction(action)

    present(controller, animated: true, completion: nil)
  }

  func showErrorInAlert(_ error: Error, onDismiss: @escaping () -> Void) {
    let controller = UIAlertController(
      title: "Error",
      message: error.localizedDescription,
      preferredStyle: .alert
    )
    let action = UIAlertAction(title: "Dismiss", style: .cancel) { _ in
      controller.dismiss(animated: true, completion: nil)
      onDismiss()
    }
    controller.addAction(action)

    present(controller, animated: true, completion: nil)
  }
}
