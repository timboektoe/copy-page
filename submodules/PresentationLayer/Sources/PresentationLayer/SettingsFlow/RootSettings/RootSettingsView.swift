import UIKit
import Base

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
