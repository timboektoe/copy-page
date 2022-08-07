import UIKit

struct DocumentCellUiModel: Hashable {
	var id: UUID
	var name: String
	var image: UIImage
	var url: URL
}

class DocumentsPresenter: DocumentsPresenterProtocol {

	enum DocumentsSection: CaseIterable {
		case main
	}

	lazy var dataSource = configureDataSource()

	var view: DocumentsViewProtocol

	var onSelect: ((URL) -> Void)?

	required init(_ view: DocumentsViewProtocol) {
		self.view = view
	}

	func updateDataSource(with cells: [DocumentCellUiModel]) {
		var snapshot = NSDiffableDataSourceSnapshot<DocumentsSection, DocumentCellUiModel>()
		snapshot.appendSections(DocumentsSection.allCases)
		snapshot.appendItems(cells, toSection: .main)
		dataSource.apply(snapshot)
	}

	let cellIdentifier = "documentCell"
	func configureDataSource() -> UITableViewDiffableDataSource<DocumentsSection, DocumentCellUiModel> {
		view.contentView.content.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
		return UITableViewDiffableDataSource(
			tableView: view.contentView.content.tableView,
			cellProvider: { tableView, indexPath, uiModel in
				let cell = tableView.dequeueReusableCell(
					withIdentifier: "documentCell",
					for: indexPath
				) as UITableViewCell

				cell.textLabel?.text = uiModel.name
				return cell
			}
		)
	}

	func didSelectItem(at indexPath: IndexPath) {
		guard let item = dataSource.itemIdentifier(for: indexPath) else {
			// error
			return
		}

		onSelect?(item.url)
	}
}
