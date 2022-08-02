//
//  UserDocumentsView.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit

class UserDocumentsView: UIView {

	// MARK: Fields
	var items: UIStackView = UIStackView()

	// MARK: Initializer

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()

		setupLayout()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Methods

	func setupView() {
		items.spacing = 20
		items.alignment = .center
		items.axis = .vertical
		items.distribution = .equalCentering
	}

	func setupLayout() {

		let itemsView: UIView = {
			let view = UIView()
			view.backgroundColor = AppColors.accent
			view.addSubview(items)
			items.translatesAutoresizingMaskIntoConstraints = false

			NSLayoutConstraint.activate([
				items.widthAnchor.constraint(equalTo: view.widthAnchor),
				items.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
//				items.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -10)
			])
			return view
		}()

		let contentStack: UIStackView = {
			let stackView = UIStackView(arrangedSubviews: [itemsView])
			stackView.axis = .vertical
			stackView.spacing = 20
			return stackView
		}()

		addSubview(contentStack)

		contentStack.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
			contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
			contentStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			contentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	func configure(cellsUiModels: [UserDocumentsUiModel.UserDocumentsCellUiModel]) {
		cellsUiModels.forEach { cellUiModel in
			let cell = UserDocumentsNavigationСell()

			cell.configure(
				title: cellUiModel.title,
				subtitle: cellUiModel.subtitle,
				image: cellUiModel.image,
				action: cellUiModel.action
			)

			items.addArrangedSubview(cell)

			cell.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				cell.heightAnchor.constraint(equalToConstant: 60),
				cell.widthAnchor.constraint(equalTo: widthAnchor, constant: -60),
			])
		}
	}
}
