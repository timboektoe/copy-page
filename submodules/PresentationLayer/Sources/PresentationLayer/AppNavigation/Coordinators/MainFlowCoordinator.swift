import Foundation
import BusinessLogicLayer

public protocol MainFlowCoordinatorOutput: AnyObject {
	var finishFlow: (() -> Void)? { get set }
}

class MainFlowCoordinator: BaseCoordinator, MainFlowCoordinatorOutput {

	var finishFlow: (() -> Void)?

	private let moduleFactory: MainFlowModuleFactory
	private let router: Router

	internal init(moduleFactory: ModuleFactory, router: Router) {
		self.moduleFactory = moduleFactory
		self.router = router
	}

	override func start() {
		showDocumentsNavigationModule()
	}

	func showDocumentsNavigationModule() {
		let documentsNavigationModule = moduleFactory.makeUserDocumentsNavigationModule(onSelect: showDocumentPreview(for:))
		router.setRootModule(documentsNavigationModule, hideBar: true)
	}

	func showDocumentsModule(for type: DocumentsRepository.DocumentType) {
		InjectedValues[\.documentsRepositoryKey] = DocumentsRepository(type: type)
		let documentsModule = moduleFactory.makeDocumentsModule(onSelect: showDocumentPreview(for:))
		router.push(documentsModule, animated: true)
	}

	func showDocumentPreview(for url: URL) {
		let previewModule = moduleFactory.makeDocumentsPreviewModule(itemURL: url)
		router.push(previewModule)
	}
}
