//
//  FormView.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit

public class FormView<Content: UIView, Header: HeaderView>: UIView {

	// MARK: Fields

	var viewStack: UIStackView = UIStackView()

	public var header: Header = Header() {

		willSet {
			viewStack.removeArrangedSubview(header)
		}

		didSet {
			viewStack.insertArrangedSubview(header, at: 0)
		}

	}

	public var content: Content = Content()


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

	}

	func setupLayout() {
		viewStack.addArrangedSubview(header)
		viewStack.addArrangedSubview(content)

		viewStack.axis = . vertical

		addSubview(viewStack)

		viewStack.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			viewStack.leadingAnchor.constraint(equalTo: leadingAnchor),
			viewStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
			viewStack.trailingAnchor.constraint(equalTo: trailingAnchor),
			viewStack.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
