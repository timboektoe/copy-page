//
//  WebNavigationViewController.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

class WebNavigationViewController: UIViewController {

	var viewModel: WebNavigationViewModelProtocol = WebNavigationViewModel()

	@UseAutoLayout var contentView = FormView<WebNavigationView, HeaderView>()

	override func viewDidLoad() {
		super.viewDidLoad()

		viewModel.output = self

		setupView()

		contentView.header = HeaderFactory().makeWebNavigationHeader()

		// MARK: - Handle background

		NotificationCenter.default.addObserver(self, selector: #selector(movedFromBackground), name: UIApplication.didBecomeActiveNotification, object: nil)
	}

	@objc func movedFromBackground() {
		viewModel.forceUpdate()
		debugPrint(UserDefaultsManager.container.array(forKey: "extensionErrors"))
	}

	func setupView() {

		view.backgroundColor = .white
		view.addSubview(contentView)

		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

		contentView.content.collectionView.dataSource = self
		contentView.content.collectionView.delegate = self
	}

	func displayPromptView(promptView: HeaderView) {
		contentView.header = promptView
	}

	func animatedHidePrompt(promptView: HeaderView) {
		UIView.animate(withDuration: 0.5, delay: 0, animations: {
			promptView.frame = CGRect(
				x: promptView.frame.origin.x,
				y: -promptView.frame.maxY,
				width: promptView.frame.width,
				height: promptView.frame.height
			)
		}, completion: { success in
			if success {
				self.contentView.isUserInteractionEnabled = true
				promptView.removeFromSuperview()
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

		let promptView = HeaderFactory().makeMoveToWebHeader(
			with: cell.title,
			with: cell.displayPromptHeader,
			completion: {
				self.contentView.isUserInteractionEnabled = true
				self.contentView.header = HeaderFactory().makeWebNavigationHeader()
			}
		)

		displayPromptView(promptView: promptView)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width * 0.35, height: collectionView.frame.width * 0.35)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return collectionView.frame.width*0.05
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 30, left: collectionView.frame.width*0.1, bottom: 0, right: collectionView.frame.width*0.1)
	}
}

extension WebNavigationViewController: WebNavigationViewModelOutput {
	
	func uiModelDidUpdate() {
		DispatchQueue.main.async {
			self.contentView.content.collectionView.reloadData()
		}
	}

	func displayDonePrompt() {
		DispatchQueue.main.async {
			let header = HeaderFactory().doneWebHeader(action: {
				self.navigationController?.pushViewController(UserDocumentsViewController(), animated: false)
			})
			self.displayPromptView(promptView: header)
		}
	}
}
