public protocol ScrapDataFlowCoordinatorOutput: AnyObject {
	var finishFlow: (() -> Void)? { get set }
}

class ScrapDataFlowCoordinator: BaseCoordinator, ScrapDataFlowCoordinatorOutput {

	var finishFlow: (() -> Void)?

	private let moduleFactory: MainFlowModuleFactory
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
