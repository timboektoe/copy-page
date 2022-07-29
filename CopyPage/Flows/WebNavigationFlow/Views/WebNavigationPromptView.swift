//
//  WebNavigationPromptView.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 26.07.2022.
//

import UIKit

class WebNavigationPromptView: UIView {

	// MARK: Fields

	var titleImageView = UIImageView()

	var titleLabel = UILabel()

	var headlineLabel = UILabel()

	var descriptionLabel = UILabel()

	var startButton = UIButton()

	var completion: (() -> Void)?

	private var onStart: (() -> Void)?

	// MARK: Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		setupLayout()

	}

	// MARK: Methods

	func setupView() {
		backgroundColor = .white

		titleLabel.numberOfLines = 0
		titleLabel.font = .preferredFont(forTextStyle: .title1)
		headlineLabel.font = .preferredFont(forTextStyle: .headline)
		descriptionLabel.numberOfLines = 0
		descriptionLabel.textAlignment = .center

		startButton.backgroundColor = AppColors.accent
		startButton.addTarget(self, action: #selector(startButtonTouchDown), for: .touchDown)
	}

	func setupLayout() {

		let stackView = UIStackView(arrangedSubviews: [titleImageView, titleLabel, headlineLabel, descriptionLabel, startButton])

		stackView.alignment = .center
		stackView.axis = .vertical
		stackView.spacing = 20
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.directionalLayoutMargins = .init(top: 0, leading: 0, bottom: 40, trailing: 0)

		addSubview(stackView)

		stackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])

		startButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			startButton.heightAnchor.constraint(equalToConstant: 40),
			startButton.widthAnchor.constraint(equalToConstant: frame.width * 0.4)
		])
	}

	func configure(
		with uiModel: WebNavigationUiModel.PromptUiModel,
		onStart: (() -> Void)?
	) {
		titleImageView.image = uiModel.titleImage
		titleLabel.text = uiModel.title
		headlineLabel.text  = uiModel.headline
		descriptionLabel.text = uiModel.description
		startButton.setTitle(uiModel.startButtonText, for: .normal)

		self.onStart = onStart
	}

	@objc private func startButtonTouchDown() {
		onStart?()
		completion?()
	}
}
