import UIKit
import Base
import BusinessLogicLayer

enum Settings: String, CaseIterable, Hashable {
	case reset = "Delete all data"
}

protocol RootSettingsViewProtocol {
	var contentView: RootSettingsView { get }
}

protocol RootSettingsPresenterProtocol: AnyObject {

	init(_ view: RootSettingsViewProtocol)

	func updateDataSource(with cells: [Settings])

	func itemAtIndexPath(indexPath: IndexPath) -> Settings
}

protocol RootSettingsInteractorProtocol {

	init(_ presenter: RootSettingsPresenterProtocol)

	func loadCells()

	func didSelectCell(at indexPath: IndexPath)

}

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

class RootSettingsInteractor: RootSettingsInteractorProtocol {

	var onReset: (() -> Void)?

	@Injected(\.webItemRepositoryKey)
	var repository: WebItemsRepositoryProtocol

	let presenter: RootSettingsPresenterProtocol

	required init(_ presenter: RootSettingsPresenterProtocol) {
		self.presenter = presenter
	}

	func loadCells() {
		presenter.updateDataSource(with: Settings.allCases)
	}

	func didSelectCell(at indexPath: IndexPath) {
		let item = presenter.itemAtIndexPath(indexPath: indexPath)

		switch item {
		case .reset:

			repository.readWebModels().forEach { model in
				UserDefaultsManager.container.removeObject(forKey: model.source)
			}

			onReset?()
		}
	}
}


class RootSettingsViewController: UIViewController, RootSettingsViewProtocol, UITableViewDelegate {

	@UseAutoLayout var contentView = RootSettingsView()

	var interactor: RootSettingsInteractorProtocol!

	override func viewDidLoad() {
		super.viewDidLoad()

		contentView.tableView.delegate = self
		interactor.loadCells()

		setupView()
		setupLayout()
	}

	func setupView() {	}

	func setupLayout() {

		view.addSubview(contentView)

		contentView.constraintsEqualToSuperview()
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor.didSelectCell(at: indexPath)
	}
}

class RootSettingsView: UIView {
	@UseAutoLayout var tableView = UITableView(frame: .zero, style: .grouped)

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() { }

	func setupLayout() {
		addSubview(tableView)
		tableView.constraintsEqualToSuperview()
	}

}
