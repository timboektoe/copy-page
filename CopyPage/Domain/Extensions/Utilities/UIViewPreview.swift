import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI
public struct UIViewPreview<View: UIView>: UIViewRepresentable {
  let view: View

  public init(_ builder: @escaping () -> View) {
	view = builder()
  }

  // MARK: - UIViewRepresentable
  public func makeUIView(context: Context) -> UIView {
	return view
  }

  public func updateUIView(_ view: UIView, context: Context) {
	view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
	view.setContentHuggingPriority(.defaultHigh, for: .vertical)
  }
}
#endif
