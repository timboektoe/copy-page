import Base
import BusinessLogicLayer

class UserDocumentsNavigationInteractor: UserDocumentsNavigationInteractorProtocol {

	var onSelect: ((DocumentsRepository.DocumentType) -> Void)?

	var presenter: UserDocumentsNavigationPresenterProtocol

	required init(_ presenter: UserDocumentsNavigationPresenterProtocol) {
		self.presenter = presenter
	}

	func loadView() {
		presenter.setupHeader()
		presenter.setupCells([
			.init(
				title: L10n.Documentsnavigationview.Tiles.Uwv.title,
				subtitle: L10n.Documentsnavigationview.Tiles.Uwv.subtitle,
				image: Asset.pdfIcon.image,
				action: {
					self.onSelect?(.uwv)
			}),
			.init(
				title: L10n.Documentsnavigationview.Tiles.Pensioen.title,
				subtitle: L10n.Documentsnavigationview.Tiles.Pensioen.subtitle,
				image: Asset.pdfIcon.image,
				action: {
					self.onSelect?(.pension)
			}),
			.init(
				title: L10n.Documentsnavigationview.Tiles.Images.title,
				subtitle: L10n.Documentsnavigationview.Tiles.Images.subtitle,
				image: Asset.imageIcon.image,
				action: {
					self.onSelect?(.belastingdienst)
			})
		])
	}

}
