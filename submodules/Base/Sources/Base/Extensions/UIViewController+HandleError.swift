import UIKit
import PKHUD

public extension UIViewController {

	func showProgressView() {
		HUD.show(.progress)
	}

	func showHudErrorView(title: String = L10n.Error.defaulttitle, subtitle: String, dismissAfter: TimeInterval = 2) {
		HUD.show(.labeledError(title: title, subtitle: subtitle))
	}

	func showErrorView(title: String = L10n.Error.defaulttitle, subtitle: String, button: String = L10n.Error.defaultButtonTitle) {
		let alertView = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
		alertView.addAction(UIAlertAction(title: button, style: .cancel))
		self.present(alertView, animated: true)
	}
}
