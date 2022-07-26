//
//  WebNavigationView.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

class WebNavigationView: UIView {

	// MARK: - Fields

	var imageTitle = UIImageView()

	var title = UILabel()

	var subtitle = UILabel()

	lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)

	var collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

	// MARK: - Initializers

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

		collectionView.register(WebNavigationCellView.self, forCellWithReuseIdentifier: "cell")
		collectionView.backgroundColor = AppColors.background

		title.textColor = .black
		title.font = .preferredFont(forTextStyle: .title1)
		subtitle.textAlignment = .center

		subtitle.textColor = .black
		subtitle.numberOfLines = 0

	}

	func setupLayout() {

		let headerViewStack = UIStackView(arrangedSubviews: [imageTitle, title, subtitle])
		headerViewStack.axis = .vertical
		headerViewStack.spacing = 20
		headerViewStack.backgroundColor = .white
		headerViewStack.alignment = .center

		let contentStack = UIStackView(arrangedSubviews: [headerViewStack, collectionView])
		contentStack.axis = .vertical
		contentStack.spacing = 20

		addSubview(contentStack)

		contentStack.translatesAutoresizingMaskIntoConstraints = false
		contentStack.constraintsEqualToSuperview()
	}

	func configure(with uiModel: WebNavigationUiModel) {
		title.text = uiModel.title
		subtitle.text = uiModel.subtitle
		imageTitle.image = uiModel.titleImage
	}
}
