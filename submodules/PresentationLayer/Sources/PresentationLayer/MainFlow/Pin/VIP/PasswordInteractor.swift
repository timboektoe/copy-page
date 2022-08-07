import BusinessLogicLayer

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
