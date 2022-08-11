import UIKit

class RootSettingsPresenter: RootSettingsPresenterProtocol {

	enum RootSettingsSection: CaseIterable {
		case main
	}

	lazy var dataSource = configureDataSource()

	var view: RootSettingsViewProtocol

	required init(_ view: RootSettingsViewProtocol) {
		self.view = view
	}

	func updateDataSource(with cells: [Settings]) {
		var snapshot = NSDiffableDataSourceSnapshot<RootSettingsSection, Settings>()
		snapshot.appendSections(RootSettingsSection.allCases)
		snapshot.appendItems(cells, toSection: .main)
		dataSource.apply(snapshot)
	}

	func itemAtIndexPath(indexPath: IndexPath) -> Settings {
		return .reset
	}

	let cellIddentifier = "settingsCell"
	private func configureDataSource() -> UITableViewDiffableDataSource<RootSettingsSection, Settings> {
		view.contentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIddentifier)
		return UITableViewDiffableDataSource(
			tableView: view.contentView.tableView,
			cellProvider: { tableView, indexPath, uiModel in
				let cell = tableView.dequeueReusableCell(
					withIdentifier: self.cellIddentifier,
					for: indexPath
				) as UITableViewCell

				cell.textLabel?.text = uiModel.rawValue
				return cell
			})
	}

}
