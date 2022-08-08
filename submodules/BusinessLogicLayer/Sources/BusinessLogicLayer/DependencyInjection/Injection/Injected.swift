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

public struct PDFFromBase64ProviderKey: InjectionKey {
	static public var currentValue: PDFFromBase64ProviderProtocol = PDFFromBase64Provider()
}

public extension InjectedValues {
	var pDFromBase64ProviderKey: PDFFromBase64ProviderProtocol {
		get { Self[PDFFromBase64ProviderKey.self] }
		set { Self[PDFFromBase64ProviderKey.self] = newValue }
	}
}
