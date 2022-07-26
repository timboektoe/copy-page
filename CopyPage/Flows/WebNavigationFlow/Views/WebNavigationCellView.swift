//
//  WebNavigationCellView.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

class WebNavigationCellView: UICollectionViewCell {

	// MARK: - Fields

	var imageView: UIImageView = UIImageView()

	var label: UILabel = UILabel()

	var tickImage: UIImageView = UIImageView()

	// MARK: - Initializer

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func prepareForReuse() {
		super.prepareForReuse()

		imageView.image = nil
		label.text = nil
	}

	// MARK: - Methods

	func setupView() {
		backgroundColor = .clear

		imageView.contentMode = .scaleAspectFill
		tickImage.image = Asset.tick.image
	}

	func setupLayout() {
		let stackView = UIStackView(arrangedSubviews: [imageView, label])

		stackView.backgroundColor = .white
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.layer.cornerRadius = 10
		stackView.layer.masksToBounds = true
		stackView.spacing = 20

		addSubview(stackView)

		let inset = frame.width * 0.08

		stackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: stackView.superview!.leadingAnchor, constant: inset),
			stackView.trailingAnchor.constraint(equalTo: stackView.superview!.trailingAnchor, constant: -inset),
			stackView.topAnchor.constraint(equalTo: stackView.superview!.topAnchor, constant: inset),
			stackView.bottomAnchor.constraint(equalTo: stackView.superview!.bottomAnchor, constant: -inset)
		])

		addSubview(tickImage)

		tickImage.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			tickImage.leadingAnchor.constraint(equalTo: tickImage.superview!.leadingAnchor),
			tickImage.topAnchor.constraint(equalTo: tickImage.superview!.topAnchor),
			tickImage.heightAnchor.constraint(equalToConstant: 50),
			tickImage.widthAnchor.constraint(equalToConstant: 50)
		])
	}
}
