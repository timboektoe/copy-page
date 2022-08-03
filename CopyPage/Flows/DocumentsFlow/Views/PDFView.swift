//
//  PDFView.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit
import PDFKit

class PDFPreviewViewController: UIViewController {

	@UseAutoLayout var pdfView: PDFView = PDFView()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		setupLayout()
	}

	func setupLayout() {
		view.addSubview(pdfView)

		NSLayoutConstraint.activate([
			pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			pdfView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
			pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	func loadPDF(with url: URL) {
		if let pdfDocument = PDFDocument(url: url) {
			pdfView.displayMode = .singlePageContinuous
			pdfView.autoScales = true
			pdfView.displayDirection = .vertical
			pdfView.document = pdfDocument
		}
	}
}

class ImagePreviewViewController: UIViewController {

	@UseAutoLayout var imageView: UIImageView = UIImageView()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()

		setupLayout()

	}

	func setupLayout() {
		view.addSubview(imageView)
		view.backgroundColor = .white

		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
			imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	func setupView() {

	}

	func loadImage(with url: URL) {
		imageView.image = UIImage(contentsOfFile: url.path)
		imageView.contentMode = .scaleAspectFit
	}
}
