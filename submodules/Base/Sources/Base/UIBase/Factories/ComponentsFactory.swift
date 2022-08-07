//
//  ComponentsFactory.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit


class ComponentsFactory {

	func makeButton(
		with text: String,
		action: @escaping () -> Void
	) -> UIButton {
		let button = UIButton()
		button.setBackgroundColor(AppColors.accent)
		button.setTitle(text, for: .normal)
		button.addAction(action)

		button.setPadding(.init(top: 20, left: 20, bottom: 20, right: 20))

		NSLayoutConstraint.activate([
			button.heightAnchor.constraint(equalToConstant: 40)
		])

		return button
	}

	func makeHeaderTitle(with text: String) -> UILabel {
		let label = UILabel()
		label.textAlignment = .center
		label.font = .preferredFont(forTextStyle: .title1)
		label.numberOfLines = 0
		label.text = text
		return label
	}

	func makeHeaderSubtitle(with text: String) -> UILabel {
		let label = UILabel()
		label.textAlignment = .center
		label.text = text
		label.numberOfLines = 0
		return label
	}
}
