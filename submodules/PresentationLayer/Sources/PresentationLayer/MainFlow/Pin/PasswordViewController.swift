import UIKit
import Base

public class PinViewController: UIViewController, UITextFieldDelegate, PasswordViewProtocol {

	@UseAutoLayout var contentView = PinCodeView()

	var interactor: PasswordInteractorProtocol!

	public init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		setupLayout()
	}

	func setupView() {
		contentView.textField.delegate = self
		contentView.button.addAction { [weak self] in
			guard let self = self else { return }
			self.interactor.textFieldDidDone(with: self.contentView.textField.text ?? "")
		}
	}

	func setupLayout() {
		view.addSubview(contentView)
		contentView.constraintsEqualToSuperview()
	}

	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		interactor.textFieldDidDone(with: textField.text ?? "")
		return true
	}
}

extension UIViewController {

	func presentAlert(title: String? = "", message: String? = "") {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		self.present(alert, animated: true)
	}
}

class PinCodeView: UIView {

	@UseAutoLayout var label = UILabel()

	@UseAutoLayout var textField = UITextField()

	@UseAutoLayout var button = UIButton()


	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() {

		backgroundColor = .systemGray4

		textField.backgroundColor = .white
		textField.layer.masksToBounds = true
		textField.layer.cornerRadius = 10
		textField.textAlignment = .center
		textField.returnKeyType = .done

		label.text = L10n.Pinview.caption
		label.font = .preferredFont(forTextStyle: .caption1)
		label.textColor = .black

		button.setTitle(L10n.Pinview.button, for: .normal)
		button.backgroundColor = .systemBlue
		button.layer.masksToBounds = true
		button.layer.cornerRadius = 10

	}

	func setupLayout() {
		addSubview(label)
		addSubview(textField)
		addSubview(button)


		NSLayoutConstraint.activate([
			textField.centerXAnchor.constraint(equalTo: centerXAnchor),
			textField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -35),
			textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
			textField.heightAnchor.constraint(equalToConstant: 40)
		])

		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: centerXAnchor),
			label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5)
		])

		NSLayoutConstraint.activate([
			button.centerXAnchor.constraint(equalTo: centerXAnchor),
			button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
			button.heightAnchor.constraint(equalToConstant: 40),
			button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30)
		])
	}
}
