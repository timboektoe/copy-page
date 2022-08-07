import Base
import UIKit
import PDFKit

class MediaPreviewViewController: UIViewController, DocumentPreviewViewProtocol {

	@UseAutoLayout var contentView = MediaPreviewView()

	var interactor: DocumentPreviewInteractor!

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		setupLayout()

		interactor.loadView()
	}

	func setupView() {
		view.backgroundColor = .white
	}

	func setupLayout() {
		view.addSubview(contentView)

		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
		])
	}
}

class MediaPreviewView: UIView {

	var preview: UIView = UIView()

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() {	}

	func setupLayout() {
		addSubview(preview)

		preview.translatesAutoresizingMaskIntoConstraints = false
		preview.constraintsEqualToSuperview()
	}

	func configure(with url: URL) {
		if url.pathExtension == "pdf" {
			if let pdfDocument = PDFDocument(url: url) {
				print("pdf doc")
				buildPreview(.pdf(pdfDocument: pdfDocument))
			} else {
				// Catch error
				self.preview.backgroundColor = .green
			}
		} else {
			if let image = UIImage(contentsOfFile: url.path) {
				buildPreview(.image(image: image))
			} else {
				// Catch error
				self.preview.backgroundColor = .green
			}
		}
	}

	enum Preview {
		case image(image: UIImage)
		case pdf(pdfDocument: PDFDocument)
	}

	private func buildPreview(_ preview: Preview) {

		func setupConstraint(for view: UIView) {
			view.translatesAutoresizingMaskIntoConstraints = false
			self.preview.addSubview(view)

			NSLayoutConstraint.activate([
				view.leadingAnchor.constraint(equalTo: self.preview.leadingAnchor),
				view.topAnchor.constraint(equalTo: self.preview.safeAreaLayoutGuide.topAnchor),
				view.trailingAnchor.constraint(equalTo: self.preview.trailingAnchor),
				view.bottomAnchor.constraint(equalTo: self.preview.bottomAnchor),
			])
		}

		switch preview {
		case .image(let image):
			let imageView = UIImageView()
			imageView.image = image
			imageView.contentMode = .scaleAspectFit
			setupConstraint(for: imageView)
		case .pdf(let pdfDocument):
			let pdfView = PDFView()
			pdfView.displayMode = .singlePageContinuous
			pdfView.displayDirection = .vertical
			pdfView.document = pdfDocument
			pdfView.autoScales = true
			setupConstraint(for: pdfView)
		}
	}
}
