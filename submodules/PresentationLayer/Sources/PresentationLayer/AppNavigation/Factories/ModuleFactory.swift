import Foundation
import BusinessLogicLayer
import UIKit

protocol MainFlowModuleFactory {

	func makeWebNavigationModule(onDone: (() -> Void)?) -> ScrapDataWebNavigationViewController

	func makeUserDocumentsNavigationModule(onSelect: ((DocumentsRepository.DocumentType) -> Void)?) -> UserDocumentsViewController

	func makeDocumentsModule(onSelect: @escaping (URL) -> Void) -> DocumentsViewController

	func makeDocumentsPreviewModule(itemURL: URL) -> MediaPreviewViewController 

	func makePasswordModule(onDone: (() -> Void)?) -> PinViewController
}

protocol SettingsFlowModuleFactory {

	func makeRootSettingsViewController(onReset: (() -> Void)?) -> RootSettingsViewController
}

protocol TabBarModuleFactory {
	func makeTabBarModule(
		viewDidLoad: @escaping (UINavigationController) -> (),
		onItemFlowSelect: @escaping (UINavigationController) -> (),
		onSettingsFlowSelect: @escaping (UINavigationController) -> ()
	) -> TabbarController
}

class ModuleFactory:
	MainFlowModuleFactory,
	SettingsFlowModuleFactory,
	TabBarModuleFactory {

	func makeRootSettingsViewController(onReset: (() -> Void)?) -> RootSettingsViewController {
		let viewController = RootSettingsViewController()
		let presenter = RootSettingsPresenter(viewController)
		let interactor = RootSettingsInteractor(presenter)
		interactor.onReset = onReset
		viewController.interactor = interactor
		return viewController
	}

	func makeTabBarModule(
		viewDidLoad: @escaping (UINavigationController) -> Void,
		onItemFlowSelect: @escaping (UINavigationController) -> (),
		onSettingsFlowSelect: @escaping (UINavigationController) -> ()
	) -> TabbarController {
		let tabBarController = TabbarController()
		tabBarController.onViewDidLoad = viewDidLoad
		tabBarController.onItemFlowSelect = onItemFlowSelect
		tabBarController.onSettingsFlowSelect = onSettingsFlowSelect
		return tabBarController
	}


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

	func makePasswordModule(onDone: (() -> Void)?) -> PinViewController {
		let viewController = PinViewController()
		let presenter = PasswordPresenter(viewController)
		viewController.interactor = PasswordInteractor(presenter)
		viewController.interactor.onDone = onDone
		return viewController
	}
}
