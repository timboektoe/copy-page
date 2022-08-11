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

	lazy var dataSource: UITableViewDiffableDataSource<DocumentsSection, DocumentCellUiModel> = {
		DispatchQueue.main.sync {
			return configureDataSource()
		}
	}()
	var view: DocumentsViewProtocol

	var onSelect: ((URL) -> Void)?

	required init(_ view: DocumentsViewProtocol) {
		self.view = view
		view.contentView.content.tableView.register(DocumentsCellView.self, forCellReuseIdentifier: cellIdentifier)
	}

	func updateDataSource(with cells: [DocumentCellUiModel]) {
		var snapshot = NSDiffableDataSourceSnapshot<DocumentsSection, DocumentCellUiModel>()
		snapshot.appendSections(DocumentsSection.allCases)
		snapshot.appendItems(cells, toSection: .main)
		dataSource.apply(snapshot)
	}

	let cellIdentifier = "documentCell"
	func configureDataSource() -> UITableViewDiffableDataSource<DocumentsSection, DocumentCellUiModel> {
		return UITableViewDiffableDataSource(
			tableView: view.contentView.content.tableView,
			cellProvider: { tableView, indexPath, uiModel in
				let cell = tableView.dequeueReusableCell(
					withIdentifier: self.cellIdentifier,
					for: indexPath
				) as? DocumentsCellView

				cell?.configure(with: uiModel)
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
