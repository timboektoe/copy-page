
public protocol CoordinatorFactoryProtocol {
	func makeMainFlowCoordinator() -> BaseCoordinator & MainFlowCoordinatorOutput

	func makeScrapDataFlowCoordinator() -> BaseCoordinator & ScrapDataFlowCoordinatorOutput

	func makePasswordFlowCoordinator() -> BaseCoordinator & PasswordFlowCoordinatorOutput

	func setRouter(router: Router)

}


public class CoordinatorFactory: CoordinatorFactoryProtocol {

	var router: Router!

	public init() {	}

	public func makeMainFlowCoordinator() -> BaseCoordinator & MainFlowCoordinatorOutput {
		return MainFlowCoordinator(moduleFactory: ModuleFactory(), router: router)
	}

	public func makeScrapDataFlowCoordinator() -> BaseCoordinator & ScrapDataFlowCoordinatorOutput {
		return ScrapDataFlowCoordinator(moduleFactory: ModuleFactory(), router: router)
	}

	public func makePasswordFlowCoordinator() -> BaseCoordinator & PasswordFlowCoordinatorOutput {
		return PasswordFlowCoordinator(moduleFactory: ModuleFactory(), router: router)
	}

	public func setRouter(router: Router) {
		self.router = router
	}
}
