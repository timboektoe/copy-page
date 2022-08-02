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
		backgroundColor = .white
		layer.masksToBounds = true
		clipsToBounds = false
		layer.cornerRadius = 10

		imageView.contentMode = .scaleAspectFit

		tickImage.image = Asset.tick.image

		label.font = .preferredFont(forTextStyle: .body)
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
	}

	func setupLayout() {

		addSubview(imageView)
		addSubview(label)
		addSubview(tickImage)

		imageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -10)
		])

		label.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: leadingAnchor),
			label.trailingAnchor.constraint(equalTo: trailingAnchor),
			label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
		])

		tickImage.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			tickImage.leadingAnchor.constraint(equalTo: tickImage.superview!.leadingAnchor, constant: -15),
			tickImage.topAnchor.constraint(equalTo: tickImage.superview!.topAnchor, constant: -15),
			tickImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
			tickImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
		])
	}
}
