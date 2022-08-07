import Foundation

class DocumentPreviewPresenter: DocumentPreviewPresenterProtocol {

	var view: DocumentPreviewViewProtocol

	required init(_ view: DocumentPreviewViewProtocol) {
		self.view = view
	}

	func setupPreview(for url: URL) {
		view.contentView.configure(with: url)
	}

}
