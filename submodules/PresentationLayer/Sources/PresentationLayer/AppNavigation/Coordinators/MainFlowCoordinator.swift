import Foundation
import BusinessLogicLayer

public protocol MainFlowCoordinatorOutput: AnyObject {
	var finishFlow: (() -> Void)? { get set }
}

class MainFlowCoordinator: BaseCoordinator, MainFlowCoordinatorOutput {

	var finishFlow: (() -> Void)?

	private let moduleFactory: WebNavigationModuleFactory
	private let router: Router

	internal init(moduleFactory: ModuleFactory, router: Router) {
		self.moduleFactory = moduleFactory
		self.router = router
	}

	override func start() {
		showDocumentsNavigationModule()
	}

	func showDocumentsNavigationModule() {
		let documentsNavigationModule = moduleFactory.makeUserDocumentsNavigationModule(onSelect: showDocumentsModule)
		router.setRootModule(documentsNavigationModule, hideBar: true)
	}

	func showDocumentsModule(for type: DocumentsRepository.DocumentType) {
		InjectedValues[\.documentsRepositoryKey] = DocumentsRepository(type: type)
		let documentsModule = moduleFactory.makeDocumentsModule(onSelect: showDocumentPreview(for:))
		router.push(documentsModule)
	}

	func showDocumentPreview(for url: URL) {
		let previewModule = moduleFactory.makeDocumentsPreviewModule(itemURL: url)
		router.push(previewModule)
	}
}

public protocol ScrapDataFlowCoordinatorOutput: AnyObject {
	var finishFlow: (() -> Void)? { get set }
}

class ScrapDataFlowCoordinator: BaseCoordinator, ScrapDataFlowCoordinatorOutput {

	var finishFlow: (() -> Void)?

	private let moduleFactory: WebNavigationModuleFactory
	private let router: Router

	internal init(moduleFactory: ModuleFactory, router: Router) {
		self.moduleFactory = moduleFactory
		self.router = router
	}

	override func start() {
		showMakeWebNavigationModule()
	}

	func showMakeWebNavigationModule() {
		let scrapDataNavigationModule = moduleFactory.makeWebNavigationModule(onDone: finishFlow)
		router.setRootModule(scrapDataNavigationModule, hideBar: true)
	}
}
