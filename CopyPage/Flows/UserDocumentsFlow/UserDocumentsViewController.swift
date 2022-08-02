//
//  UserDocumentsViewController.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit

class UserDocumentsViewController: UIViewController {

	var contentView = FormView<UserDocumentsView, HeaderView>()

	override func viewDidLoad() {
		super.viewDidLoad()


		setupView()

		setupLayout()
	}

	func setupView() {

		contentView.header = HeaderFactory().documentsNavigationViewHeader()

		view.backgroundColor = .white
	}

	func setupLayout() {

		view.addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

	}
}

class UserDocumentsView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() {
		backgroundColor = AppColors.background
	}
}
