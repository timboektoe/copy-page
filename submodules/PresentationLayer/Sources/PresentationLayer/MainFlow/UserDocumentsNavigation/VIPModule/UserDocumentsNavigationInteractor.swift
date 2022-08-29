import Base
import BusinessLogicLayer
import Foundation

enum UserDocumentsError: LocalizedError {
	case cantFindDocumentFolder
}

class UserDocumentsNavigationInteractor: UserDocumentsNavigationInteractorProtocol {

	var onSelect: ((URL) -> Void)?

	var presenter: UserDocumentsNavigationPresenterProtocol

	required init(_ presenter: UserDocumentsNavigationPresenterProtocol) {
		self.presenter = presenter
	}

	func loadView() {
		presenter.setupHeader()
		presenter.setupCells(loadFiles())
	}

	func loadFiles() -> Result<[UserDocumentsCellUiModel], Error> {
		let fileManager = FileManager.default

		guard let documentsFolder = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
			return .failure(UserDocumentsError.cantFindDocumentFolder)
		}

		do {
			let content = try fileManager.contentsOfDirectory(atPath: documentsFolder.path)

			let cells: [UserDocumentsCellUiModel] = content.compactMap { item in

				let url = URL(fileURLWithPath: documentsFolder.appendingPathComponent(item).path)

				if item.contains(".png") {
					return UserDocumentsCellUiModel(
						title: url.deletingPathExtension().lastPathComponent,
						subtitle: "-",
						image: Asset.imageIcon.image,
						action: { self.onSelect?(url) }
					)
				} else if item.contains(".pdf") {
					return UserDocumentsCellUiModel(
						title: url.deletingPathExtension().lastPathComponent,
						subtitle: "-",
						image: Asset.pdfIcon.image,
						action: { self.onSelect?(url) })
				} else {
					return nil
				}
			}

			return .success(cells)
		} catch {
			return .failure(error)
		}
	}
}
