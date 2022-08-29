import Base
import UIKit

struct UserDocumentsCellUiModel {
	let title: String
	let subtitle: String
	let image: UIImage
	let action: () -> Void
}

class UserDocumentsNavigationPresenter: UserDocumentsNavigationPresenterProtocol {

	var view: UserDocumentsNavigationViewProtocol

	required init(_ view: UserDocumentsNavigationViewProtocol) {
		self.view = view
	}

	func setupHeader() {
		view.contentView.header = HeaderFactory().documentsNavigationViewHeader()
	}

	func setupCells(_ result: Result<[UserDocumentsCellUiModel], Error>) {
		switch result {
		case .success(let cells): view.contentView.content.configure(cellsUiModels: cells)
		case .failure(let error): view.showErrorView(subtitle: error.localizedDescription)
		}
	}
}
