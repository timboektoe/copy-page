//
//  Some.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 20.07.2022.
//

import UIKit

class HomeViewController: UIViewController {

	let groupUserDefaults = UserDefaults(suiteName: "group.copypage.safariappextension")

	lazy var openSafariButton: UIButton = {
		let button = UIButton()
		button.setTitle("Open Aqopi.com", for: .normal)
		button.backgroundColor = .systemBlue
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.masksToBounds = true
		button.layer.cornerRadius = 20
		return button
	}()

	lazy var forceUpdateButton: UIButton = {
		let button = UIButton()
		button.setTitle("Force update response", for: .normal)
		button.backgroundColor = .systemBlue
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.masksToBounds = true
		button.layer.cornerRadius = 20
		return button
	}()

	lazy var cleanUserDefaultsButton: UIButton = {
		let button = UIButton()
		button.setTitle("Clean response", for: .normal)
		button.backgroundColor = .systemBlue
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.masksToBounds = true
		button.layer.cornerRadius = 20
		return button
	}()

	lazy var responseTextView: UITextView = {
		let label = UITextView()
		label.text = "No response"
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .black
		label.backgroundColor = .white
		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		setupLayout()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateResponse()
	}

	func setupView() {
		view.backgroundColor = .white
		view.addSubview(openSafariButton)
		view.addSubview(responseTextView)
		view.addSubview(cleanUserDefaultsButton)
		view.addSubview(forceUpdateButton)

		forceUpdateButton.addTarget(self, action: #selector(updateResponse), for: .touchDown)
		cleanUserDefaultsButton.addTarget(self, action: #selector(cleanUserDefaults), for: .touchDown)
		openSafariButton.addTarget(self, action: #selector(openWeb), for: .touchDown)
	}

	func setupLayout() {

		let forceUpdateButtonConstraints = [
			forceUpdateButton.bottomAnchor.constraint(equalTo: cleanUserDefaultsButton.topAnchor, constant: -30),
			forceUpdateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			forceUpdateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			forceUpdateButton.heightAnchor.constraint(equalToConstant: 50)
		]

		let cleanReponseButtonConstraints = [
			cleanUserDefaultsButton.bottomAnchor.constraint(equalTo: openSafariButton.topAnchor, constant: -30),
			cleanUserDefaultsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			cleanUserDefaultsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			cleanUserDefaultsButton.heightAnchor.constraint(equalToConstant: 50)
		]
		
		let safariButtonConstraints = [
			openSafariButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			openSafariButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			openSafariButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			openSafariButton.heightAnchor.constraint(equalToConstant: 50)
		]

		let responseLabelConstraints = [
			responseTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			responseTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			responseTextView.topAnchor.constraint(equalTo: openSafariButton.bottomAnchor),
			responseTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		]

		NSLayoutConstraint.activate(forceUpdateButtonConstraints)
		NSLayoutConstraint.activate(cleanReponseButtonConstraints)
		NSLayoutConstraint.activate(safariButtonConstraints)
		NSLayoutConstraint.activate(responseLabelConstraints)
	}

	@objc func openWeb() {
		if let url = URL(string: "https://acct-stubs.aqopi.com/stub.html?source=moh&profile=test&timeout=0&redirects=0&redirectTimeout=0") {
			UIApplication.shared.open(url)
		}
	}

	@objc func cleanUserDefaults() {
		self.groupUserDefaults?.set("Cleaned", forKey: "test")
		updateResponse()
	}

	@objc func updateResponse() {
		responseTextView.text = groupUserDefaults?.string(forKey: "test") ?? "User Defaults is empty"
	}
}
