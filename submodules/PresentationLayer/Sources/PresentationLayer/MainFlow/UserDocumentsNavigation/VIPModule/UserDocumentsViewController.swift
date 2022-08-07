import Base
import UIKit

public class UserDocumentsViewController: UIViewController, UserDocumentsNavigationViewProtocol {

	@UseAutoLayout var contentView = FormView<UserDocumentsView, HeaderView>()

	var interactor: UserDocumentsNavigationInteractorProtocol!

	public override func viewDidLoad() {
		super.viewDidLoad()

		interactor.loadView()

		setupView()

		setupLayout()
	}

	func setupView() {

		contentView.header = HeaderFactory().documentsNavigationViewHeader()

		view.backgroundColor = .white
	}

	func setupLayout() {

		view.addSubview(contentView)

		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

	}
}


