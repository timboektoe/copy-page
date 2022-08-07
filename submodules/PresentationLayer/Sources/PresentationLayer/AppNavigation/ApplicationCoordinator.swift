import Base

fileprivate enum LaunchInstructor {
	case password, scrapdata, main

	static func configure(
		isPasswordNeeded: Bool = false,
		isDataScraped: Bool = false
	) -> LaunchInstructor {
		if isPasswordNeeded {
			return .password
		}

		if !isDataScraped {
			return .scrapdata
		}

		return .main
	}
}

final public class ApplicationCoordinator: BaseCoordinator {

	private let router: Router
	private let coordinatorFactory: CoordinatorFactoryProtocol

	var isPasswordNeeded = false

	@Store(key: "isDataScraped", defaultValue: false)
	var isDataScraped: Bool

	public init(router: Router, coordinatorFactory: CoordinatorFactoryProtocol) {
		self.router = router
		self.coordinatorFactory = coordinatorFactory
		coordinatorFactory.setRouter(router: router)
	}

	override public func start() {
		switch LaunchInstructor.configure(
			isPasswordNeeded: isPasswordNeeded,
			isDataScraped: isDataScraped
		) {
		case .password:
			runPasswordFlow()
		case .scrapdata:
			runScrapDataFlow()
		case .main:
			runMainFlow()
		}
	}

	func runMainFlow() {
		let coordinator = coordinatorFactory.makeMainFlowCoordinator()
		coordinator.finishFlow = { [weak self] in
			self?.removeDependency(coordinator)
		}
		addDependency(coordinator)
		coordinator.start()
	}

	func runScrapDataFlow() {
		let coordinator = coordinatorFactory.makeScrapDataFlowCoordinator()
		coordinator.finishFlow = { [weak self] in
			self?.isDataScraped = true
			self?.start()
			self?.removeDependency(coordinator)
		}
		addDependency(coordinator)
		coordinator.start()
	}

	func runPasswordFlow() {
		let coordinator = coordinatorFactory.makePasswordFlowCoordinator()
		coordinator.finishFlow = { [weak self] in
			self?.isPasswordNeeded = false
			self?.start()
			self?.removeDependency(coordinator)
		}
		addDependency(coordinator)
		coordinator.start()
	}
}
