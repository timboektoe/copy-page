import UIKit

public extension UIControl {
		func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping () -> Void) {
			if #available(iOS 14.0, *) {
				self.enumerateEventHandlers { action, targetAction, event, stop in
					if let action = action {
						self.removeAction(action, for: event)
					}
					if let (target, selector) = targetAction {
						self.removeTarget(target, action: selector, for: event)
					}
					stop = true
				}
			} else {
				removeTarget(nil, action: nil, for: .allEvents)
			}

			if #available(iOS 14, *) {
				addAction(UIAction { (_: UIAction) in closure() }, for: controlEvents)
			} else {
				@objc class ClosureSleeve: NSObject {
					let closure: () -> Void
					init(_ closure: @escaping () -> Void) { self.closure = closure }
					@objc func invoke() { closure() }
				}
				let sleeve = ClosureSleeve(closure)
				addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
				objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
			}
		}
}
