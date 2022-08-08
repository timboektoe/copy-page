import Foundation
import UIKit
import PDFKit

struct ConsumerModel: Codable {
	let signature, signatureVersion: String
	let data: ConsumerData
}

// MARK: - DataClass
struct ConsumerData: Codable {
	let id, parserID, type: String
	let url: String
	let consumerHostname: String
	let timestamp: Int
	let payload: String

	enum CodingKeys: String, CodingKey {
		case id
		case parserID = "parserId"
		case type, url, consumerHostname, timestamp, payload
	}
}


public protocol PDFFromBase64ProviderProtocol {
	func get() -> PDFDocument
}

public class PDFFromBase64Provider: PDFFromBase64ProviderProtocol {

	public init() { }

	public func get() -> PDFDocument {
		guard let model = getModel() else {
			return PDFDocument()
		}

		let data = transformBaseStringToData(dataClass: model)

		let document =  PDFDocument(data: data)

		return document!
	}

	func transformBaseStringToData(dataClass: ConsumerData) -> Data {
		let data = Data(base64Encoded: String(dataClass.payload.components(separatedBy: "base64,").last!), options: .ignoreUnknownCharacters)

		return data ?? Data()
	}

	func getModel() -> ConsumerData? {
		guard let url = Bundle.main.url(forResource: "iwize-nl", withExtension: "json") else {
			return nil
		}

		do {
			let data = try Data(contentsOf: url)

			let model = try JSONDecoder().decode(ConsumerModel.self, from: data)

			return model.data
		} catch {
			print(error.localizedDescription)
		}
		return nil
	}
}

