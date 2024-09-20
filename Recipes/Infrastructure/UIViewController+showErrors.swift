import UIKit

extension UIViewController {
    func showErrorAllert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAxtion = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAxtion)
        present(alertController, animated: true, completion: nil)
    }
}
