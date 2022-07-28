import Foundation

extension UserDefaults {

   public func observe<T: Any>(key: String, callback: @escaping (T) -> Void) -> Observable {
	  let result = KeyValueObserver<T>.observeNew(object: self, keyPath: key) {
		 callback($0)
	  }
	  return result
   }

   public func observeString(key: String, callback: @escaping (String) -> Void) -> Observable {
	  return observe(key: key, callback: callback)
   }
}
