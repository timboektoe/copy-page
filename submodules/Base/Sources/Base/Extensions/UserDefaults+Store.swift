import Foundation

@propertyWrapper
public struct Store<Value> {
	public let key: String
	public let defaultValue: Value
	public var container: UserDefaults = .standard

	public init(key: String, defaultValue: Value) {
		self.key = key
		self.defaultValue = defaultValue
	}

	public var wrappedValue: Value {
		get {
			return container.object(forKey: key) as? Value ?? defaultValue
		}
		set {
			container.set(newValue, forKey: key)
		}
	}
}
