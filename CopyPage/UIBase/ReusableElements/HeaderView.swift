//
//  Header.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 01.08.2022.
//

import UIKit

class HeaderView: UIView {

	// MARK: - Fields

	private var viewStack: UIStackView = UIStackView()

	private var logoImage: UIImageView = UIImageView(image: Asset.appLogo.image)
	
	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()

		setupLayout()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Methods

	func setupView() {
		viewStack.addArrangedSubview(logoImage)
		viewStack.axis = .vertical
		viewStack.spacing = 20
		viewStack.alignment = .center

		logoImage.contentMode = .scaleAspectFit

		backgroundColor = .white
	}

	func setupLayout() {

		addSubview(viewStack)

		viewStack.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			viewStack.leadingAnchor.constraint(equalTo: leadingAnchor),
			viewStack.topAnchor.constraint(equalTo: topAnchor),
			viewStack.trailingAnchor.constraint(equalTo: trailingAnchor),
			viewStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
		])
	}

	func add(view: UIView) {
		viewStack.addArrangedSubview(view)
	}
}
