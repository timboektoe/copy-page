import Foundation

class DocumentPreviewInteractor: DocumentPreviewInteractorProtocol {

	var itemURL: URL?

	var presenter: DocumentPreviewPresenterProtocol

	required init(_ presenter: DocumentPreviewPresenterProtocol) {
		self.presenter = presenter
	}

	func loadView() {
		guard let itemURL = itemURL else {
			return
		}

		presenter.setupPreview(for: itemURL)
	}
}

