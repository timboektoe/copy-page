import UIKit
import QuickLookThumbnailing

enum DocumentRepositoryError: LocalizedError {
	case unknownError
}

public protocol DocumentsRepositoryProtocol {

	func get(completion: @escaping (Result<[DocumentModel], Error>) -> Void)

}

public struct DocumentModel {
	public var id: UUID
	public var name: String
	public var url: URL
	public var preview: UIImage
}


public class DocumentsRepository: DocumentsRepositoryProtocol {

	public enum DocumentType {
		case uwv, pension, belastingdienst
	}

	var type: DocumentType = .belastingdienst

	public init(type: DocumentType = .uwv) {
		self.type = type
	}

	public func get(completion: @escaping (Result<[DocumentModel], Error>) -> Void) {

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

		generateThumbnail(for: url, completion: { image in
			completion(.success(
				[
					.init(id: .init(), name: name, url: url, preview: image),
					.init(id: .init(), name: "\(name)-1", url: url, preview: image),
					.init(id: .init(), name: "\(name)-2", url: url, preview: image),
					.init(id: .init(), name: "\(name)-3", url: url, preview: image)
				]
			))
		})
	}

	public func generateThumbnail(for url: URL, completion: @escaping (UIImage) -> Void) {

		let size: CGSize = CGSize(width: 60, height: 60)

		let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: 1, representationTypes: .all)

		let generator = QLThumbnailGenerator.shared
		generator.generateRepresentations(for: request) { (thumbnail, type, error) in

			if let image = thumbnail?.uiImage {
				completion(image)
			}

			completion(UIImage())

		}
	}
}
