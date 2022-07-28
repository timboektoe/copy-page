//
//  WebNavigationViewController.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

class WebNavigationViewController: UIViewController {

	var viewModel: WebNavigationViewModelProtocol = WebNavigationViewModel()

	@UseAutoLayout var contentView: WebNavigationView = WebNavigationView()
	@UseAutoLayout var promptView: WebNavigationPromptView = WebNavigationPromptView()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()

		contentView.configure(with: viewModel.uiModel)
		displayPromptView()
	}

	func setupView() {
		view.backgroundColor = .white
		view.addSubview(contentView)

		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

		contentView.collectionView.dataSource = self
		contentView.collectionView.delegate = self
	}

	func displayPromptView() {
		promptView.configure(with: viewModel.uiModel.prompt, onStart: {
			self.animatedHidePrompt()
		})
		contentView.addSubview(promptView)

		promptView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			promptView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			promptView.topAnchor.constraint(equalTo: contentView.topAnchor),
			promptView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			promptView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
		])
	}

	func animatedHidePrompt() {
		UIView.animate(withDuration: 0.5, delay: 0, animations: {
			self.promptView.frame = CGRect(
				x: self.promptView.frame.origin.x,
				y: -self.promptView.frame.maxY,
				width: self.promptView.frame.width,
				height: self.promptView.frame.height
			)
		}, completion: { success in
			if success {
				self.promptView.removeFromSuperview()
			}
		})
	}
}

extension WebNavigationViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.uiModel.cells.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WebNavigationCellView else {
			return UICollectionViewCell()
		}

		let cellUiModel = viewModel.uiModel.cells[indexPath.row]

		cell.imageView.image = cellUiModel.image
		cell.label.text = cellUiModel.title
		cell.tickImage.isHidden = !cellUiModel.ticked
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = viewModel.uiModel.cells[indexPath.row]

		if cell.ticked {
			return
		}

		viewModel.uiModel.cells[indexPath.row].route()
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width * 0.4, height: collectionView.frame.width * 0.4)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 30, left: collectionView.frame.width*0.1, bottom: 0, right: collectionView.frame.width*0.1)
	}
}

