import Base
import BusinessLogicLayer
import UIKit

protocol UserDocumentsNavigationViewProtocol: UIViewController {
	var contentView: FormView<UserDocumentsView, HeaderView> { get }
}

protocol UserDocumentsNavigationPresenterProtocol: AnyObject {

	init(_ view: UserDocumentsNavigationViewProtocol)

	func setupHeader()

	func setupCells(_ result: Result<[UserDocumentsCellUiModel], Error>) 

}

protocol UserDocumentsNavigationInteractorProtocol {

	var onSelect: ((URL) -> Void)? { get set }

	init(_ presenter: UserDocumentsNavigationPresenterProtocol)

	func loadView()

}
