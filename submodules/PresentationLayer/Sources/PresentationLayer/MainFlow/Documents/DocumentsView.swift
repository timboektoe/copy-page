import UIKit
import Base

class DocumentsView: UIView {

	var tableView = UITableView(frame: .zero, style: .grouped)

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()

		setupLayout()

		
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() {
		backgroundColor = AppColors.background
		tableView.backgroundColor = AppColors.background
		tableView.register(DocumentsCellView.self, forCellReuseIdentifier: "cell")
	}

	func setupLayout() {
		addSubview(tableView)

		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

class DocumentsCellView: UITableViewCell {

	@UseAutoLayout var title = UILabel()

	@UseAutoLayout var subtitle = UILabel()

	@UseAutoLayout var image = UIImageView()

	override func layoutSubviews() {
		super.layoutSubviews()

		setupView()

		setupLayout()
	}

	func setupView() {

	}

	func setupLayout() {
		addSubview(title)
		addSubview(subtitle)
		addSubview(image)

		NSLayoutConstraint.activate([
			image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
		])

		NSLayoutConstraint.activate([
			title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
			title.centerYAnchor.constraint(equalTo: centerYAnchor)
		])

	}

	func configure(with uiModel: DocumentCellUiModel) {
		self.title.text = uiModel.name
		self.image.image = uiModel.image
	}
}
