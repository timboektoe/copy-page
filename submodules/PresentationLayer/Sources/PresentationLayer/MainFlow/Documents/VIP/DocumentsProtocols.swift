import Base
import BusinessLogicLayer
import UIKit

protocol DocumentsViewProtocol {
	var contentView: FormView<DocumentsView, HeaderView> { get }
}

protocol DocumentsPresenterProtocol {

	var onSelect: ((URL) -> Void)? { get set }

	init(_ view: DocumentsViewProtocol)

	func updateDataSource(with cells: [DocumentCellUiModel])

	func didSelectItem(at indexPath: IndexPath) 

}

protocol DocumentsInteractorProtocol {

	init(_ presenter: DocumentsPresenterProtocol)

	func loadCells()

	func didSelectCell(at indexPath: IndexPath)
}
