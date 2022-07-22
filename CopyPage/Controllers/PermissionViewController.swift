//
//  HomePage.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 20.07.2022.
//

import UIKit

class PermissionViewController: UIViewController {

	lazy var imageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "Icon")!)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	lazy var caption: UIButton = {
		let button = UIButton()
		button.setTitle("Turn on CopyPage's\nSafari Extension in Settings", for: .normal)
		button.setTitleColor(UIColor.black, for: .normal)
		button.titleLabel?.numberOfLines = 0
		button.titleLabel?.textAlignment = .center
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	lazy var button: UIButton = {
		let button = UIButton()
		button.setTitle("I turned on extension", for: .normal)
		button.backgroundColor = .systemBlue
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.masksToBounds = true
		button.layer.cornerRadius = 20
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		setupLayout()
	}

	func setupView() {
		view.backgroundColor = .white

		caption.addTarget(self, action: #selector(openSettings), for: .touchDown)
		button.addTarget(self, action: #selector(moveToNextPage), for: .touchDown)
	}

	func setupLayout() {
		let stackView = UIStackView(arrangedSubviews: [imageView, caption, button])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .equalCentering
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 0, bottom: 100, trailing: 0)

		view.addSubview(stackView)

		let stackViewConstraints = [
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stackView.topAnchor.constraint(equalTo: view.topAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		]


		let imageViewContraints = [
			imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
		]

		let captionConstraints = [
			caption.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
		]

		let buttonConstraints = [
			button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			button.heightAnchor.constraint(equalToConstant: 50)
		]

		NSLayoutConstraint.activate(stackViewConstraints)
		NSLayoutConstraint.activate(imageViewContraints)
		NSLayoutConstraint.activate(captionConstraints)
		NSLayoutConstraint.activate(buttonConstraints)
	}

	@objc func openSettings() {
		if let url = URL.init(string: UIApplication.openSettingsURLString.appending("Safari")) {
			UIApplication.shared.open(url)
		}
	}

	@objc func moveToNextPage() {
		let homeViewController = HomeViewController()
		homeViewController.modalPresentationStyle = .fullScreen
		self.present(homeViewController, animated: false)
	}

	override func beginRequest(with context: NSExtensionContext) {
		print(context)
	}
}
