import Foundation
import Base
import BusinessLogicLayer

protocol UserDocumentsNavigationViewProtocol {
	var contentView: FormView<UserDocumentsView, HeaderView> { get }
}

protocol UserDocumentsNavigationPresenterProtocol: AnyObject {

	init(_ view: UserDocumentsNavigationViewProtocol)

	func setupHeader()

	func setupCells(_ cells: [UserDocumentsCellUiModel]) 

}

protocol UserDocumentsNavigationInteractorProtocol {

	var onSelect: ((DocumentsRepository.DocumentType) -> Void)? { get set }

	init(_ presenter: UserDocumentsNavigationPresenterProtocol)

	func loadView()

}
