//
//  UserDocumentsView.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import Foundation
import UIKit

struct UserDocumentsUiModel {
	struct UserDocumentsCellUiModel {
		let title: String
		let subtitle: String
		let image: UIImage
		let action: () -> Void
	}

	let cells: [UserDocumentsCellUiModel]
}

protocol UserDocumentsViewModelProtocol {
	var uiModel: UserDocumentsUiModel { get set }
}

class UserDocumentsViewModel: UserDocumentsViewModelProtocol {
	var uiModel: UserDocumentsUiModel

	init() {
		self.uiModel = .init(cells: [
			.init(title: L10n.Documentsnavigationview.Tiles.Uwv.title, subtitle: L10n.Documentsnavigationview.Tiles.Uwv.subtitle, image: Asset.pdfIcon.image, action: {
				print("some text")
			}),
			.init(title: L10n.Documentsnavigationview.Tiles.Pensioen.title, subtitle: L10n.Documentsnavigationview.Tiles.Pensioen.subtitle, image: Asset.pdfIcon.image, action: {
				print("some text 2")
			}),
			.init(title: L10n.Documentsnavigationview.Tiles.Images.title, subtitle: L10n.Documentsnavigationview.Tiles.Images.subtitle, image: Asset.imageIcon.image, action: {
				print("some text 3")
			})
		])
	}
}
