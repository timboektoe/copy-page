import Foundation

struct DeepLinkURLConstants {
  static let Wenavigation = "overviewweb"
}


public enum DeepLinkOption {

	case webnavigation

	static public func build(last component: String) -> DeepLinkOption? {
		switch component {
		case DeepLinkURLConstants.Wenavigation: return webnavigation
		default: return nil
		}
	}
}
