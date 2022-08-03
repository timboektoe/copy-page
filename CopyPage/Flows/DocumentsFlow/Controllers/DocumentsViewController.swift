//
//  DocumentsViewController.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit

class DocumentsViewController: UIViewController {

	var viewModel: DocumentsViewModelProtocol!

	@UseAutoLayout var contentView = FormView<DocumentsView, HeaderView>()


	override func viewDidLoad() {
		super.viewDidLoad()

		setupLayout()

		setupView()

		contentView.content.tableView.delegate = self
		contentView.content.tableView.dataSource = self

		navigationController?.setNavigationBarHidden(false, animated: false)

	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if self.isMovingFromParent {
			navigationController?.setNavigationBarHidden(true, animated: false)
		}
	}

	func setupView() {
		view.backgroundColor = .white
	}

	func setupLayout() {

		view.addSubview(contentView)

		contentView.constraintsEqualToSuperview()
	}
}

extension DocumentsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.uiModel.cells.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
//			return .init()
//		}

		let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")

		cell.detailTextLabel?.text = "details"
		cell.textLabel?.text = viewModel.uiModel.cells[indexPath.row].title
		
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let navigationController = navigationController else { return }
		viewModel.uiModel.cells[indexPath.row].moveToPreview(navigationController)
	}
}

class DocumentsView: UIView {

	var tableView = UITableView(frame: .zero, style: .grouped)

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()

		setupLayout()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() {
		backgroundColor = AppColors.background
		tableView.backgroundColor = AppColors.background
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func setupLayout() {
		addSubview(tableView)

		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
