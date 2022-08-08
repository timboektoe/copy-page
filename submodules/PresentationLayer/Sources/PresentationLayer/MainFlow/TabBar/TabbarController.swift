import UIKit

protocol TabbarView: AnyObject, Presentable {
	var onItemFlowSelect: ((UINavigationController) -> ())? { get set }
	var onSettingsFlowSelect: ((UINavigationController) -> ())? { get set }
	var onViewDidLoad: ((UINavigationController) -> ())? { get set }
}

final class TabbarController: UITabBarController, UITabBarControllerDelegate, TabbarView {

	var onItemFlowSelect: ((UINavigationController) -> ())?
	var onSettingsFlowSelect: ((UINavigationController) -> ())?
	var onViewDidLoad: ((UINavigationController) -> ())?

	override func viewDidLoad() {
		super.viewDidLoad()

		viewControllers = [
			createNavController(title: "Home", image: UIImage(systemName: "house")!),
			createNavController(title: "Settings", image: UIImage(systemName: "gearshape")!)
		]

		delegate = self

		if let controller = customizableViewControllers?.first as? UINavigationController {
			onViewDidLoad?(controller)
		}

		setupView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let controller = customizableViewControllers?.first as? UINavigationController {
			onViewDidLoad?(controller)
		}
	}

	func setupView() {
		self.tabBar.backgroundColor = .white
	}

	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }

		if selectedIndex == 0 {
			onItemFlowSelect?(controller)
		}
		else if selectedIndex == 1 {
			onSettingsFlowSelect?(controller)
		}
	}


	fileprivate func createNavController(title: String, image: UIImage) -> UIViewController {
	   let navController = UINavigationController()
	   navController.tabBarItem.title = title
	   navController.tabBarItem.image = image
	   return navController
   }
}
