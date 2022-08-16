import UIKit
import Base

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
