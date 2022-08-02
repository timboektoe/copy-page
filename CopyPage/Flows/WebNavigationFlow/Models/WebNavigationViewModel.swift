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
	func buildPromptForView(for site: WebSiteElement)
}

protocol WebNavigationViewModelOutput {

	func uiModelDidUpdate()
	func displayDonePrompt()
}

class WebNavigationViewModel: WebNavigationViewModelProtocol {
	var uiModel: WebNavigationUiModel!
	var output: WebNavigationViewModelOutput?

	private var repository = WebItemsRepository()

	init(uiModel: WebNavigationUiModel) {
		self.uiModel = uiModel
	}

	init() {
		self.uiModel = .init(
			titleImage: Asset.appLogo.image,
			title: L10n.Webnavigationview.Header.title,
			subtitle: L10n.Webnavigationview.Header.subtitle,
			cells: []
		)
	}


	func makeUiModel(completion: @escaping () -> Void) {
		if self.uiModel.cells.isEmpty {
			repository.getWebModels { result in
				switch result {
				case .success(let sites):
					self.uiModel.cells = sites.compactMap { item in
						if let image = UIImage(named: item.imageName) {
							return .init(
								title: item.name,
								image: image,
								ticked: UserDefaultsManager.container.bool(forKey: item.source),
								displayPromptHeader: {
									return self.buildPromptForView(for: item)
								}
							)
						}
						return nil
					}
					completion()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		} else {
			self.uiModel.cells = self.repository.readWebModels().compactMap { item in

				if !self.uiModel.cells.map({ return $0.title }).contains(item.name) {
					return nil
				}

				if let image = UIImage(named: item.imageName) {
					return .init(
						title: item.name,
						image: image,
						ticked: UserDefaultsManager.container.bool(forKey: item.source),
						displayPromptHeader: {
							return self.buildPromptForView(for: item)
						}
					)
				}
				return nil
			}

			completion()
		}
	}

	func buildPromptForView(for site: WebSiteElement) {
		guard let url = URL(string: site.url) else {
			return
		}

		UIApplication.shared.open(url)
	}

	func forceUpdate() {
		DispatchQueue.main.async {
			self.makeUiModel {

				self.output?.uiModelDidUpdate()

				if self.uiModel.cells.allSatisfy({ $0.ticked }) {
					self.output?.displayDonePrompt()
				}
			}
		}
	}
}
