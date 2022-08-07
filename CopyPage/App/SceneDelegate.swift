//
//  SceneDelegate.swift
//  CopyPage
//
//  Created by Tim van der Heijden on 16/07/2022.
//

import PresentationLayer
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

	var navigationController: UINavigationController = {
		let navigationController = UINavigationController()
//		navigationController.navigationBar.isTranslucent = false

		return navigationController
	}()

	lazy var applicationCoordinator = ApplicationCoordinator(
		router: RouterImp(rootController: navigationController),
		coordinatorFactory: CoordinatorFactory()
	)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
		window.overrideUserInterfaceStyle = .light

		self.window = window

		applicationCoordinator.start()
    }
}
