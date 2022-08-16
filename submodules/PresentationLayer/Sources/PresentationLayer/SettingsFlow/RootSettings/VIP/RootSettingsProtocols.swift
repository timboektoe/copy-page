import UIKit
import Base
import BusinessLogicLayer

enum Settings: String, CaseIterable, Hashable {
	case reset = "Delete all data"
}

protocol RootSettingsViewProtocol {
	var contentView: RootSettingsView { get }
}

protocol RootSettingsPresenterProtocol: AnyObject {

	init(_ view: RootSettingsViewProtocol)

	func updateDataSource(with cells: [Settings])

	func itemAtIndexPath(indexPath: IndexPath) -> Settings
}

protocol RootSettingsInteractorProtocol {

	init(_ presenter: RootSettingsPresenterProtocol)

	func loadCells()

	func didSelectCell(at indexPath: IndexPath)

}
