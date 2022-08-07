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

public protocol DocumentsRepositoryProtocol {

	func get(completion: (Result<[DocumentModel], Error>) -> Void)

}

public struct DocumentModel {
	public var id: UUID
	public var name: String
	public var url: URL
}


public class DocumentsRepository: DocumentsRepositoryProtocol {

	public enum DocumentType {
		case uwv, pension, belastingdienst
	}

	var type: DocumentType = .belastingdienst

	public init(type: DocumentType = .uwv) {
		self.type = type
	}

	public func get(completion: (Result<[DocumentModel], Error>) -> Void) {

		let name = "sample"
		var format: String

		switch type {
		case .uwv:
			format = "pdf"
		case .pension:
			format = "pdf"
		case .belastingdienst:
			format = "png"
		}

		guard let url = Bundle.main.url(forResource: name, withExtension: format) else {
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
