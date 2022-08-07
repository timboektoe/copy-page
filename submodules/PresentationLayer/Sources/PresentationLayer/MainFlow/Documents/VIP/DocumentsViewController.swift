import Base
import UIKit

class DocumentsViewController: UIViewController, DocumentsViewProtocol {

	var interactor: DocumentsInteractorProtocol!

	@UseAutoLayout var contentView = FormView<DocumentsView, HeaderView>()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupLayout()

		setupView()

		interactor.loadCells()

	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
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

		contentView.content.tableView.delegate = self
	}

	func setupLayout() {

		view.addSubview(contentView)
		contentView.constraintsEqualToSuperview()
	}
}

extension DocumentsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor.didSelectCell(at: indexPath)
	}
}
