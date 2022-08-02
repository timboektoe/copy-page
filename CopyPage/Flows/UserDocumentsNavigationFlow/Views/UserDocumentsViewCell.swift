//
//  UserDocumentsViewCell.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit

class UserDocumentsNavigationСell: UIControl {

	// MARK: - Fields

	var title: UILabel = UILabel()

	var subtitle: UILabel = UILabel()

	var imageView: UIImageView = UIImageView()

	var action: () -> Void = { }

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
		backgroundColor = .white

		imageView.contentMode = .scaleAspectFit

	}

	func setupLayout() {

		let textStack = UIStackView(arrangedSubviews: [title, subtitle])
		textStack.axis = .vertical
		textStack.distribution = .fillProportionally

		let contentStack = UIStackView(arrangedSubviews: [textStack])
		contentStack.alignment = .center

		contentStack.translatesAutoresizingMaskIntoConstraints = false
		addSubview(contentStack)

		NSLayoutConstraint.activate([
			contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
			contentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
			contentStack.topAnchor.constraint(equalTo: topAnchor),
			contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
		])

		contentStack.isLayoutMarginsRelativeArrangement = true
		contentStack.directionalLayoutMargins = .init(top: 0, leading: 10, bottom: 0, trailing: 0)

		contentStack.addArrangedSubview(imageView)
	}

	func configure(title: String, subtitle: String, image: UIImage, action: @escaping () -> Void) {
		self.title.text = title
		self.subtitle.text = subtitle
		self.imageView.image = image
		self.action = action

		imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.trailingAnchor.constraint(equalTo: imageView.superview!.trailingAnchor, constant: -10),
			imageView.heightAnchor.constraint(equalTo: imageView.superview!.heightAnchor, constant: -15),
			imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
			imageView.centerYAnchor.constraint(equalTo: imageView.superview!.centerYAnchor)
		])
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		action()
	}
}
