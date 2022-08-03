//
//  DocumentsRepository.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import Foundation

enum DocumentRepositoryError: LocalizedError {
	case unknownError
}

protocol DocumentsRepositoryProtocol {

	func getPDF(completion: (Result<[DocumentModel], Error>) -> Void)

	func getImages(completion: (Result<[DocumentModel], Error>) -> Void)

}

struct DocumentModel {
	var id: UUID
	var name: String
	var url: URL
}


class DocumentsRepository: DocumentsRepositoryProtocol {

	func getPDF(completion: (Result<[DocumentModel], Error>) -> Void) {

		let name = "sample"

		guard let url = Bundle.main.url(forResource: name, withExtension: "pdf") else {
			completion(.failure(DocumentRepositoryError.unknownError))
			return
		}

		completion(.success(
			[
				.init(id: .init(), name: name, url: url),
				.init(id: .init(), name: "\(name)-1", url: url),
				.init(id: .init(), name: "\(name)-2", url: url),
				.init(id: .init(), name: "\(name)-3", url: url)
			]
		))
	}

	func getImages(completion: (Result<[DocumentModel], Error>) -> Void) {

		let name = "sample"

		guard let url = Bundle.main.url(forResource: name, withExtension: "png") else {
			completion(.failure(DocumentRepositoryError.unknownError))
			return
		}


		completion(.success(
			[
				.init(id: .init(), name: name, url: url),
				.init(id: .init(), name: "\(name)-1", url: url),
				.init(id: .init(), name: "\(name)-2", url: url),
				.init(id: .init(), name: "\(name)-3", url: url)
			]
		))

	}
}
