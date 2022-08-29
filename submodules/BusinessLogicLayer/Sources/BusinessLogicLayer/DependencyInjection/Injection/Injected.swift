public struct WebItemRepositoryKey: InjectionKey {
	static public var currentValue: WebItemsRepositoryProtocol = WebItemsRepository()
}

public extension InjectedValues {
	var webItemRepositoryKey: WebItemsRepositoryProtocol {
		get { Self[WebItemRepositoryKey.self] }
		set { Self[WebItemRepositoryKey.self] = newValue }
	}
}

public struct DocumentsRepositoryKey: InjectionKey {
	static public var currentValue: DocumentsRepositoryProtocol = DocumentsRepository()
}

public extension InjectedValues {
	var documentsRepositoryKey: DocumentsRepositoryProtocol {
		get { Self[DocumentsRepositoryKey.self] }
		set { Self[DocumentsRepositoryKey.self] = newValue }
	}
}
