import BusinessLogicLayer
import UIKit
import Base

protocol PasswordViewProtocol: BaseView {

	var contentView: PinCodeView { get }

}

protocol PasswordPresenterProtocol {

	init(_ view: PasswordViewProtocol)

	func textFieldDoneWithError()
}

protocol PasswordInteractorProtocol {

	var onDone: (() -> Void)? { get set }

	init(_ presenter: PasswordPresenterProtocol)

	func textFieldDidDone(with: String)
}

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

class PasswordInteractor: PasswordInteractorProtocol {

	var presenter: PasswordPresenterProtocol

	var onDone: (() -> Void)?

	required init(_ presenter: PasswordPresenterProtocol) {
		self.presenter = presenter
	}

	func textFieldDidDone(with text: String) {
		if ApplicationConfiguration.pinCodeConstant == text {
			onDone?()
		} else {
			presenter.textFieldDoneWithError()
		}
	}
}
