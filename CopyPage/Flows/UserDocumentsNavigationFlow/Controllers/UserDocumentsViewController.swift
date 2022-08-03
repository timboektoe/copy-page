//
//  UserDocumentsViewController.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit

class UserDocumentsViewController: UIViewController {

	@UseAutoLayout var contentView = FormView<UserDocumentsView, HeaderView>()

	var viewModel: UserDocumentsViewModelProtocol = UserDocumentsViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()

		contentView.content.configure(cellsUiModels: viewModel.uiModel.cells, navigationController: navigationController)

		setupView()

		setupLayout()
	}

	func setupView() {

		contentView.header = HeaderFactory().documentsNavigationViewHeader()

		view.backgroundColor = .white
	}

	func setupLayout() {

		view.addSubview(contentView)

		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

	}
}


