import Foundation

public final class KeyValueObserver<ValueType: Any>: NSObject, Observable {

   public typealias ChangeCallback = (KeyValueObserverResult<ValueType>) -> Void

   private var context = 0 // Value don't reaaly matter. Only address is important.
   private var object: NSObject
   private var keyPath: String
   private var callback: ChangeCallback

   public var isSuspended = false

   public init(object: NSObject, keyPath: String, options: NSKeyValueObservingOptions = .new,
			   callback: @escaping ChangeCallback) {
	  self.object = object
	  self.keyPath = keyPath
	  self.callback = callback
	  super.init()
	  object.addObserver(self, forKeyPath: keyPath, options: options, context: &context)
   }

   deinit {
	  dispose()
   }

   public func dispose() {
	  object.removeObserver(self, forKeyPath: keyPath, context: &context)
   }

   public static func observeNew<T>(object: NSObject, keyPath: String,
	  callback: @escaping (T) -> Void) -> Observable {
	  let observer = KeyValueObserver<T>(object: object, keyPath: keyPath, options: .new) { result in
		 if let value = result.valueNew {
			callback(value)
		 }
	  }
	  return observer
   }

   public override func observeValue(forKeyPath keyPath: String?, of object: Any?,
									 change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
	  if context == &self.context && keyPath == self.keyPath {
		 if !isSuspended, let change = change, let result = KeyValueObserverResult<ValueType>(change: change) {
			callback(result)
		 }
	  } else {
		 super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
	  }
   }
}

public struct KeyValueObserverResult<T: Any> {

   public private(set) var change: [NSKeyValueChangeKey: Any]

   public private(set) var kind: NSKeyValueChange

   init?(change: [NSKeyValueChangeKey: Any]) {
	  self.change = change
	  guard
		 let changeKindNumberValue = change[.kindKey] as? NSNumber,
		 let changeKindEnumValue = NSKeyValueChange(rawValue: changeKindNumberValue.uintValue) else {
			return nil
	  }
	  kind = changeKindEnumValue
   }

   // MARK: -

   public var valueNew: T? {
	  return change[.newKey] as? T
   }

   public var valueOld: T? {
	  return change[.oldKey] as? T
   }

   var isPrior: Bool {
	  return (change[.notificationIsPriorKey] as? NSNumber)?.boolValue ?? false
   }

   var indexes: NSIndexSet? {
	  return change[.indexesKey] as? NSIndexSet
   }
}

public protocol Observable {
   var isSuspended: Bool { get set }
   func dispose()
}

extension Array where Element == Observable {

   public func suspend() {
	  forEach {
		 var observer = $0
		 observer.isSuspended = true
	  }
   }

   public func resume() {
	  forEach {
		 var observer = $0
		 observer.isSuspended = false
	  }
   }
}
