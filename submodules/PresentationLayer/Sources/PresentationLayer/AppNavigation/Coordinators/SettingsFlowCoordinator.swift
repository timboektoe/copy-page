public protocol SettingsFlowCoordinatorOutput {
	var onReset: (() -> Void)? { get set }
}

class SettingsFlowCoordinator: BaseCoordinator, SettingsFlowCoordinatorOutput {

	var onReset: (() -> Void)?

	private let moduleFactory: SettingsFlowModuleFactory
	private let router: Router

	internal init(moduleFactory: ModuleFactory, router: Router) {
		self.moduleFactory = moduleFactory
		self.router = router
	}

	override func start() {
		showSettingsRootModule()
	}

	func showSettingsRootModule() {
		let module = moduleFactory.makeRootSettingsViewController(onReset: onReset)
		router.setRootModule(module, hideBar: false)
	}
}
