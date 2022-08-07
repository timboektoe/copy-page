import Foundation
import BusinessLogicLayer

protocol WebNavigationModuleFactory {

	func makeWebNavigationModule(onDone: (() -> Void)?) -> ScrapDataWebNavigationViewController

	func makeUserDocumentsNavigationModule(onSelect: ((DocumentsRepository.DocumentType) -> Void)?) -> UserDocumentsViewController

	func makeDocumentsModule(onSelect: @escaping (URL) -> Void) -> DocumentsViewController

	func makeDocumentsPreviewModule(itemURL: URL) -> MediaPreviewViewController 

}

class ModuleFactory:
	WebNavigationModuleFactory {

	func makeDocumentsModule(onSelect: @escaping (URL) -> Void) -> DocumentsViewController {
		let viewController = DocumentsViewController()
		let presenter = DocumentsPresenter(viewController)
		viewController.interactor = DocumentsInteractor(presenter)
		presenter.onSelect = onSelect
		return viewController
	}

	func makeWebNavigationModule(onDone: (() -> Void)?) -> ScrapDataWebNavigationViewController {
		let viewController = ScrapDataWebNavigationViewController()
		let presenter = ScrapDataWebNavigationPresenter(viewController)
		viewController.interactor = ScrapDataWebNavigationInteractor(presenter)
		viewController.interactor.onDone = onDone
		return viewController
	}


	func makeUserDocumentsNavigationModule(onSelect: ((DocumentsRepository.DocumentType) -> Void)?) -> UserDocumentsViewController {
		let viewController = UserDocumentsViewController()
		let presenter = UserDocumentsNavigationPresenter(viewController)
		viewController.interactor = UserDocumentsNavigationInteractor(presenter)
		viewController.interactor.onSelect = onSelect
		return viewController
	}

	func makeDocumentsPreviewModule(itemURL: URL) -> MediaPreviewViewController {
		let viewController = MediaPreviewViewController()
		let presenter = DocumentPreviewPresenter(viewController)
		viewController.interactor = DocumentPreviewInteractor(presenter)
		viewController.interactor.itemURL = itemURL
		return viewController
	}
}
