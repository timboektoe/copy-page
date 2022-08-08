import UIKit

public protocol TabBarCoordinatorOutput {
	var onReset: (() -> Void)? { get set }
}

class TabbarCoordinator: BaseCoordinator, TabBarCoordinatorOutput {

	private var tabbarView: TabbarView!
	private let moduleFactory: TabBarModuleFactory
	private let coordinatorFactory: CoordinatorFactory
	private let router: Router

	var onReset: (() -> Void)?

	init(moduleFactory: TabBarModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
		self.moduleFactory = moduleFactory
		self.coordinatorFactory = coordinatorFactory
		self.router = router
	}

	override func start() {
		self.tabbarView = moduleFactory.makeTabBarModule(
			viewDidLoad: runItemFlow(),
			onItemFlowSelect: runItemFlow(),
			onSettingsFlowSelect: runSettingsFlow()
		)
		router.setRootModule(tabbarView, hideBar: true)
	}

	private func runItemFlow() -> ((UINavigationController) -> ()) {
		return { [unowned self] navController in
			if navController.viewControllers.isEmpty == true {
				let itemCoordinator = self.coordinatorFactory.makeMainFlowCoordinator(navController: navController)
				self.addDependency(itemCoordinator)
				itemCoordinator.start()
			}
		}
	}

	private func runSettingsFlow() -> ((UINavigationController) -> ()) {
		return { [unowned self] navController in
			if navController.viewControllers.isEmpty == true {
				let settingsCoordinator = self.coordinatorFactory.makeSettingsFlowCoordinator(navController: navController, onReset: onReset)
				self.addDependency(settingsCoordinator)
				settingsCoordinator.start()
			}
		}
	}
}
