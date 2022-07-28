//
//  WebNavigationViewModel.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

protocol WebNavigationViewModelProtocol {
	var uiModel: WebNavigationUiModel! { get set }
	var output: WebNavigationViewModelOutput? { get set }

	func forceUpdate()
	func isDisplayPrompt() -> Bool
}

protocol WebNavigationViewModelOutput {
	func uiModelDidUpdate()
}

class WebNavigationViewModel: WebNavigationViewModelProtocol {
	var uiModel: WebNavigationUiModel!
	var output: WebNavigationViewModelOutput?

	private var repository = WebItemsRepository()

	init(uiModel: WebNavigationUiModel) {
		self.uiModel = uiModel
	}

	init() {
		self.makeUiModel()
	}


	func makeUiModel() {
		self.uiModel = .init(
			titleImage: Asset.appLogo.image,
			title: L10n.Webnavigationview.title,
			subtitle: L10n.Webnavigationview.subtitle,
			cells: repository.readWebModels().compactMap { item in
				if let image = UIImage(named: item.imageName) {
					return .init(
						title: item.name,
						image: image,
						ticked: UserDefaultsManager.container.bool(forKey: item.source),
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
	}

	func isDisplayPrompt() -> Bool {
		return true
	}

	func forceUpdate() {
		self.makeUiModel()
		self.output?.uiModelDidUpdate()
	}
}
