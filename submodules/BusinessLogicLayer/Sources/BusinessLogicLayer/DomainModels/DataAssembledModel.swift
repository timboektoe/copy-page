struct DataAssembledModel: Decodable {
	struct DocumentModel: Decodable {
		var description: String
		var payload: String
	}

	var type: String
	var documents: [DocumentModel]
}
