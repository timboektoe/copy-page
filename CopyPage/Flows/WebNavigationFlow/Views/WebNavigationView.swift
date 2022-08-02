//
//  WebNavigationView.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

class WebNavigationView: UIView {

	// MARK: - Fields

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
	}

	func setupLayout() {

		let contentStack = UIStackView(arrangedSubviews: [collectionView])
		contentStack.axis = .vertical
		contentStack.spacing = 20

		addSubview(contentStack)

		contentStack.translatesAutoresizingMaskIntoConstraints = false
		contentStack.constraintsEqualToSuperview()
	}
}

