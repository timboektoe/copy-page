import BusinessLogicLayer
import Base
import UIKit

public class ScrapDataWebNavigationViewController: UIViewController, ScrapDataWebNavigationViewProtocol {

	var interactor: ScrapDataWebNavigationInteractor!

	@UseAutoLayout var contentView = FormView<WebNavigationView, HeaderView>()

	var collectionView: UICollectionView {
		return contentView.content.collectionView
	}

	public override func viewDidLoad() {
		super.viewDidLoad()

		interactor.loadCells()

		setupView()

		contentView.header = HeaderFactory().makeWebNavigationHeader()

		// MARK: - Handdle background

		NotificationCenter.default.addObserver(self, selector: #selector(movedFromBackground), name: UIApplication.didBecomeActiveNotification, object: nil)
	}

	@objc func movedFromBackground() {
		interactor.loadCells()
	}

	func setupView() {

		view.backgroundColor = .white
		view.addSubview(contentView)

		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

		contentView.content.collectionView.delegate = self
	}

	func displayPromptView(promptView: HeaderView) {
		contentView.header = promptView
	}
}

extension ScrapDataWebNavigationViewController: UICollectionViewDelegateFlowLayout {

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width * 0.35, height: collectionView.frame.width * 0.35)
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return collectionView.frame.width*0.05
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 30, left: collectionView.frame.width*0.1, bottom: 0, right: collectionView.frame.width*0.1)
	}

	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		interactor.didSelectCell(at: indexPath)
	}
}
