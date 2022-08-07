import Base

class PasswordPresenter: PasswordPresenterProtocol {

	var view: PasswordViewProtocol

	var onDone: (() -> Void)?

	required init(_ view: PasswordViewProtocol) {
		self.view = view
	}


	func textFieldDoneWithError() {
		view.contentView.textField.text = ""
		view.presentAlert(title: nil, message: L10n.Pinview.wrongpasswordMessage)
	}
}
