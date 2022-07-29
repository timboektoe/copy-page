//
//  WebNavigationViewUiModel.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

struct WebNavigationUiModel {

	struct WebNavigationCellUiModel {
		let title: String
		let image: UIImage
		let ticked: Bool
		let action: () -> WebNavigationPromptView
	}

	struct PromptUiModel {
		let titleImage: UIImage
		let title: String
		let headline: String
		let description: String
		let startButtonText: String
	}

	let titleImage: UIImage
	let title: String
	let subtitle: String
	let cells: [WebNavigationCellUiModel]
}
