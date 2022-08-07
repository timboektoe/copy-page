import BusinessLogicLayer
import Base
import Foundation

protocol ScrapDataWebNavigationViewProtocol {
	var contentView: FormView<WebNavigationView, HeaderView> { get }
}

protocol ScrapDataWebNavigationPresenterProtocol: AnyObject {

	init(_ view: ScrapDataWebNavigationViewProtocol)
	
	func change(header with: ViewHeaders)
	func updateDataSource(with cells: [WebListCellUiModel])
	func didSelectCell(at indexPath: IndexPath)
}

protocol ScrapDataWebNavigationInteractorProtocol {

	var onDone: (() -> Void)? { get set }

	init(_ presenter: ScrapDataWebNavigationPresenterProtocol)

	func didSelectCell(at indexPath: IndexPath)
	func loadCells()

}
