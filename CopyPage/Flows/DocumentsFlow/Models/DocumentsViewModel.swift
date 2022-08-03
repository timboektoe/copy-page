//
//  DocumentsViewModel.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import Foundation
import UIKit

struct DocumentsViewUiModel {
	struct DocumentsViewCellUiModel {
		var title: String
		var subtitle: String
		var trailingItem: String
		var thumbnail: UIImage
		var moveToPreview: (UINavigationController) -> Void
	}

	var cells: [DocumentsViewCellUiModel]
}

protocol DocumentsViewModelProtocol {
	var uiModel: DocumentsViewUiModel { get set }
}


class PDFDocumentsViewModel: DocumentsViewModelProtocol {

	var uiModel: DocumentsViewUiModel

	var documentsRepository: DocumentsRepositoryProtocol = DocumentsRepository()

	init() {
		self.uiModel = .init(cells: [])

		self.documentsRepository.getPDF(completion: { result in
			switch result {
			case .success(let models):
				self.uiModel.cells = models.compactMap { item in
					return .init(
						title: item.name,
						subtitle: "some subtitle for pdf",
						trailingItem: "some trailing item",
						thumbnail: Asset.pdfIcon.image,
						moveToPreview: { navigationController in
							let viewController = PDFPreviewViewController()
							viewController.loadPDF(with: item.url)
							navigationController.pushViewController(viewController, animated: false)
					})
				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		})
	}
}

class ImageDocumentsViewModel: DocumentsViewModelProtocol {

	var uiModel: DocumentsViewUiModel

	var documentsRepository: DocumentsRepositoryProtocol = DocumentsRepository()

	init() {
		self.uiModel = .init(cells: [])

		self.documentsRepository.getImages(completion: { result in
			switch result {
			case .success(let models):
				self.uiModel.cells = models.compactMap { item in
					return .init(
						title: item.name,
						subtitle: "some subtitle for image",
						trailingItem: "some trailing item",
						thumbnail: Asset.imageIcon.image,
						moveToPreview: { navigationController in
							let viewController = ImagePreviewViewController()
							viewController.loadImage(with: item.url)
							navigationController.pushViewController(viewController, animated: false)
						}
					)
				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		})
	}
}

