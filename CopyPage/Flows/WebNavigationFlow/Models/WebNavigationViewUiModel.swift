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
		let displayPromptHeader: () -> Void
	}

	var cells: [WebNavigationCellUiModel]
}
