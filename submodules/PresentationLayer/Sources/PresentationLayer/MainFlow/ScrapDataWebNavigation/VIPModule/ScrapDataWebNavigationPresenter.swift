import UIKit
import Base

enum WebListSection: CaseIterable {
	case main
}

struct WebListCellUiModel: Hashable {
	var image: UIImage
	var title: String
	var isChecked: Bool
	var url: String

	func hash(into hasher: inout Hasher) {
		hasher.combine(title)
		hasher.combine(url)
		hasher.combine(isChecked)
	}
}

enum ViewHeaders {
	case normal
	case cellDetail(title: String, action: () -> Void, completion: (() -> Void)? = nil)
	case done(action: () -> Void)
}

class ScrapDataWebNavigationPresenter: ScrapDataWebNavigationPresenterProtocol {
	var view: ScrapDataWebNavigationViewProtocol

	lazy var dataSource = configureDataSource()

	private let cellIdentifier = "WebItemCellIdentifier"

	required init(_ view: ScrapDataWebNavigationViewProtocol) {
		self.view = view
		self.view.contentView.content.collectionView.register(WebNavigationCellView.self, forCellWithReuseIdentifier: self.cellIdentifier)
	}

	func change(header with: ViewHeaders) {
		view.contentView.header = {
			switch with {
			case .normal:
				return HeaderFactory().makeWebNavigationHeader()
			case .cellDetail(let title, let action, let completion):
				return HeaderFactory().makeMoveToWebHeader(with: title, with: action, completion: completion)
			case .done(let action):
				return HeaderFactory().doneWebHeader(action: action)
			}
		}()
	}

	func didSelectCell(at indexPath: IndexPath) {
		guard let model = dataSource.itemIdentifier(for: indexPath) else {
			return
		}

		if model.isChecked {
			return
		}

		change(
			header: .cellDetail(
				title: model.title,
				action: {
					guard let url = URL(string: model.url) else {
						return
					}

					UIApplication.shared.open(url)
				},
				completion: {
					self.change(header: .normal)
				}
			)
		)
	}

	@MainActor
	func updateDataSource(with cells: [WebListCellUiModel]) {
		var snapshot = NSDiffableDataSourceSnapshot<WebListSection, WebListCellUiModel>()
		snapshot.appendSections(WebListSection.allCases)
		snapshot.appendItems(cells, toSection: .main)
		dataSource.apply(snapshot)
	}

	private func configureDataSource() -> UICollectionViewDiffableDataSource<WebListSection, WebListCellUiModel> {
		return UICollectionViewDiffableDataSource(
			collectionView: view.contentView.content.collectionView,
			cellProvider: { collectionView, indexPath, uiModel in
				guard let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: self.cellIdentifier,
					for: indexPath
				) as? WebNavigationCellView else {
					return UICollectionViewCell()
				}

				cell.configure(with: uiModel)
				return cell
			}
		)
	}
}
