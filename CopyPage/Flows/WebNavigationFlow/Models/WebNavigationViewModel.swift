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
	func buildPromptForView(for site: WebSiteElement) -> WebNavigationPromptView
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
						action: {
							return self.buildPromptForView(for: item)
						}
					)
				}
				return nil
			}
		)
	}

	func buildPromptForView(for site: WebSiteElement) -> WebNavigationPromptView {
		let uiModel = WebNavigationUiModel.PromptUiModel(
			titleImage: Asset.appLogo.image,
			title: L10n.Webnavigationview.Prompt.title,
			headline: L10n.Webnavigationview.Prompt.headline(site.name),
			description: L10n.Webnavigationview.Prompt.description,
			startButtonText: L10n.Webnavigationview.Prompt.button
		)

		let promptView = WebNavigationPromptView()
		promptView.configure(with: uiModel, onStart: {
			guard let url = URL(string: site.url) else {
				return
			}

			UIApplication.shared.open(url)
		})
		return promptView
	}

	func forceUpdate() {
		self.makeUiModel()
		self.output?.uiModelDidUpdate()
	}
}
