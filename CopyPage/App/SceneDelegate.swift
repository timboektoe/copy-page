//
//  SceneDelegate.swift
//  CopyPage
//
//  Created by Tim van der Heijden on 16/07/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

	var navigationController: UINavigationController = {
		let navigationController = UINavigationController(rootViewController: WebNavigationViewController())
		navigationController.setNavigationBarHidden(true, animated: false)
		return navigationController
	}()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = navigationController  // Your initial view controller.
		window.makeKeyAndVisible()
		window.overrideUserInterfaceStyle = .light
		self.window = window
    }
}
