public protocol PasswordFlowCoordinatorOutput: AnyObject {
	var finishFlow: (() -> Void)? { get set }
}

class PasswordFlowCoordinator: BaseCoordinator, PasswordFlowCoordinatorOutput {

	var finishFlow: (() -> Void)?

	private let moduleFactory: MainFlowModuleFactory
	private let router: Router

	internal init(moduleFactory: MainFlowModuleFactory, router: Router) {
		self.moduleFactory = moduleFactory
		self.router = router
	}

	override func start() {
		showPasswordModule()
	}

	func showPasswordModule() {
		let module = moduleFactory.makePasswordModule(onDone: {
			self.finishFlow?()
		})
		router.setRootModule(module, hideBar: true)
	}
}
