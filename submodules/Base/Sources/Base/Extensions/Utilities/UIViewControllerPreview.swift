import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI
public struct UIViewControllerPreview<HomeViewController: UIViewController>: UIViewControllerRepresentable {
  let viewController: HomeViewController

  public init(_ builder: @escaping () -> HomeViewController) {
	viewController = builder()
  }

  // MARK: - UIViewControllerRepresentable
  public func makeUIViewController(context: Context) -> HomeViewController {
	viewController
  }

  public func updateUIViewController(
		_ uiViewController: HomeViewController,
		context: UIViewControllerRepresentableContext<UIViewControllerPreview<HomeViewController>>
	) {
	return
  }
}
#endif
