import Base
import BusinessLogicLayer
import Foundation

class RootSettingsInteractor: RootSettingsInteractorProtocol {

	var onReset: (() -> Void)?

	@Injected(\.webItemRepositoryKey)
	var repository: WebItemsRepositoryProtocol

	let presenter: RootSettingsPresenterProtocol

	required init(_ presenter: RootSettingsPresenterProtocol) {
		self.presenter = presenter
	}

	func loadCells() {
		presenter.updateDataSource(with: Settings.allCases)
	}

	func didSelectCell(at indexPath: IndexPath) {
		let item = presenter.itemAtIndexPath(indexPath: indexPath)

		switch item {
		case .reset:

			repository.readWebModels().forEach { model in
				UserDefaultsManager.container.removeObject(forKey: model.source)
			}

			onReset?()
		}
	}
}
