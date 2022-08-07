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
