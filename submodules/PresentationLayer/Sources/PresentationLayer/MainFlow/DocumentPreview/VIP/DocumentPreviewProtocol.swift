import Foundation
import Base

protocol DocumentPreviewViewProtocol {
	var contentView: MediaPreviewView { get }
}

protocol DocumentPreviewPresenterProtocol: AnyObject {

	init(_ view: DocumentPreviewViewProtocol)

	func setupPreview(for url: URL)

}

protocol DocumentPreviewInteractorProtocol {

	var itemURL: URL? { get set }

	init(_ presenter: DocumentPreviewPresenterProtocol)

	func loadView()

}
