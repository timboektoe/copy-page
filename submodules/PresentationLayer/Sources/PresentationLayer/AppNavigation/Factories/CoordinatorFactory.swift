import UIKit

public protocol CoordinatorFactoryProtocol {

	func makeTabbarCoordinator() -> BaseCoordinator & TabBarCoordinatorOutput

	func makeMainFlowCoordinator(navController: UINavigationController) -> BaseCoordinator & MainFlowCoordinatorOutput

	func makeScrapDataFlowCoordinator() -> BaseCoordinator & ScrapDataFlowCoordinatorOutput

	func makePasswordFlowCoordinator() -> BaseCoordinator & PasswordFlowCoordinatorOutput

	func makeSettingsFlowCoordinator(navController: UINavigationController, onReset: (() -> Void)?) -> BaseCoordinator & SettingsFlowCoordinatorOutput

	func setRouter(router: Router)

}

public class CoordinatorFactory: CoordinatorFactoryProtocol {

	var router: Router!

	public init() {	}

	public func makeMainFlowCoordinator(navController: UINavigationController) -> BaseCoordinator & MainFlowCoordinatorOutput {
		return MainFlowCoordinator(moduleFactory: ModuleFactory(), router: RouterImp(rootController: navController))
	}

	public func makeScrapDataFlowCoordinator() -> BaseCoordinator & ScrapDataFlowCoordinatorOutput {
		return ScrapDataFlowCoordinator(moduleFactory: ModuleFactory(), router: router)
	}

	public func makePasswordFlowCoordinator() -> BaseCoordinator & PasswordFlowCoordinatorOutput {
		return PasswordFlowCoordinator(moduleFactory: ModuleFactory(), router: router)
	}

	public func makeSettingsFlowCoordinator(navController: UINavigationController, onReset: (() -> Void)?) -> BaseCoordinator & SettingsFlowCoordinatorOutput {
		let coordinator = SettingsFlowCoordinator(moduleFactory: ModuleFactory(), router: RouterImp(rootController: navController))
		coordinator.onReset = onReset
		return coordinator
	}

	public func makeTabbarCoordinator() -> BaseCoordinator & TabBarCoordinatorOutput {
		let coordinator = TabbarCoordinator(moduleFactory: ModuleFactory(), coordinatorFactory: self, router: self.router)
		return coordinator
	}

	public func setRouter(router: Router) {
		self.router = router
	}
	
}
