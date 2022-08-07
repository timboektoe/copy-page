import BusinessLogicLayer
import Foundation
import Base

class ScrapDataWebNavigationInteractor: ScrapDataWebNavigationInteractorProtocol {

	var onDone: (() -> Void)?

	var presenter: ScrapDataWebNavigationPresenterProtocol

	@Injected(\.webItemRepositoryKey)
	var webitemsRepository: WebItemsRepositoryProtocol

	required init(_ presenter: ScrapDataWebNavigationPresenterProtocol) {
		self.presenter = presenter
	}

	func didSelectCell(at indexPath: IndexPath) {
		presenter.didSelectCell(at: indexPath)
	}

	@MainActor
	func loadCells() {
		webitemsRepository.getWebModels { [weak presenter] result in
			switch result {
			case .success(let cells):
				Task {
					let cellsUiModels = cells.compactMap {  item in
						return WebListCellUiModel(
							image: ImageAsset(name: item.imageName).image,
							title: item.name,
							isChecked: UserDefaultsManager.container.bool(forKey: item.source),
							url: item.url
						)
					}

					presenter?.updateDataSource(with: cellsUiModels)

					if cellsUiModels.allSatisfy(\.isChecked) {
						if let onDone = self.onDone {
							presenter?.change(header: .done(action: onDone))
						}
					}
				}

			case .failure(let error):
				return
			}
		}
	}
}
