//
//  WebNavigationViewModel.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

protocol WebNavigationViewModelProtocol {
	var uiModel: WebNavigationUiModel { get set }
}

class WebNavigationViewModel: WebNavigationViewModelProtocol {
	var uiModel: WebNavigationUiModel

	init(uiModel: WebNavigationUiModel) {
		self.uiModel = uiModel
	}

	init() {
		self.uiModel = .init(
			titleImage: Asset.appLogo.image,
			title: L10n.Webnavigationview.title,
			subtitle: L10n.Webnavigationview.subtitle,
			cells: readWebModels().compactMap { item in
				if let image = UIImage(named: item.imageName) {
					return .init(
						title: item.name,
						image: image,
						ticked: UserDefaultsManager.container.bool(forKey: item.url),
						route: {
							guard let url = URL(string: item.url) else {
								return
							}

							UIApplication.shared.open(url)
						}
					)
				}
				return nil
			},
			prompt: .init(
				titleImage: Asset.appLogo.image,
				title: L10n.Webnavigationview.Prompt.title,
				headline: L10n.Webnavigationview.Prompt.headline,
				description: L10n.Webnavigationview.Prompt.description,
				startButtonText: L10n.Webnavigationview.Prompt.button
			)
		)

		func readWebModels() -> WebSite {
			guard let url = Bundle.main.url(forResource: "webmodels", withExtension: "json") else {
				fatalError("Cant find url")
			}

			do {
				let data = try Data(contentsOf: url)
				let decoder = JSONDecoder()
				let result = try decoder.decode(WebSite.self, from: data)
				return result
			} catch {
				fatalError(error.localizedDescription)
			}
		}
	}
}
