import BusinessLogicLayer
import Base
import Foundation

class DocumentsInteractor: DocumentsInteractorProtocol {

	var presenter: DocumentsPresenterProtocol

	@Injected(\.documentsRepositoryKey)
	var documentsRepository: DocumentsRepositoryProtocol


	required init(_ presenter: DocumentsPresenterProtocol) {
		self.presenter = presenter
	}

	func loadCells() {
		documentsRepository.get() { result in
			switch result {
			case .success(let documents):
				let uiModel: [DocumentCellUiModel] = documents.map { document in
					return .init(id: .init(), name: document.name, image: document.preview, url: document.url)
				}
				self.presenter.updateDataSource(with: uiModel)
			case .failure(_):
				return
			}
		}

//		self.documentsRepository = DocumentsRepository()
	}

	func didSelectCell(at indexPath: IndexPath) {
		presenter.didSelectItem(at: indexPath)
	}
}
