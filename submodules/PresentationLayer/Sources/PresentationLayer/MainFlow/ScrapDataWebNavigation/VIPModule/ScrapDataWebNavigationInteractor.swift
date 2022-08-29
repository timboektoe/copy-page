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
	func loadCells(completion: @escaping (Error?) -> Void) {
		webitemsRepository.getWebModels { [weak presenter] result in
			switch result {
			case .success(let cells):
				Task {

					var cellsUiModels = cells.compactMap {  item in
						return WebListCellUiModel(
							image: ImageAsset(name: item.imageName).image,
							title: item.name,
							isChecked: UserDefaultsManager.container.bool(forKey: item.source),
							url: item.url
						)
					}

					if cellsUiModels.filter(\.isChecked).count + 1 == cellsUiModels.count,
					   let index = cellsUiModels.firstIndex(where: { return $0.isChecked == false }) {
						   cellsUiModels[index].url = self.buildURLForLastElement(stringURL: cellsUiModels[index].url)
					}

					presenter?.updateDataSource(with: cellsUiModels)

					if cellsUiModels.allSatisfy(\.isChecked),
					   let onDone = self.onDone {

						presenter?.change(
							header: .done(
								action: {
									if let error = WebMessageProcessService().processDocuments() {
										completion(error)
										return
									}
									onDone()
								}
							)
						)
					}
					
					completion(nil)
				}
			case .failure(let error): completion(error)
			}
		}
	}
	
	private func buildURLForLastElement(stringURL: String) -> String {
		guard var url = URLComponents(string: stringURL) else {
			return ""
		}

		url.queryItems?.append(URLQueryItem(name: "isLast", value: "true"))

		return url.url?.absoluteString ?? ""
	}
}
