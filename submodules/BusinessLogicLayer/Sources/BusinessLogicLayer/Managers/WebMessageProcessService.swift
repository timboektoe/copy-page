import Foundation
import PDFKit

enum WebMessageProcessorErrors: LocalizedError {
	case messageIsInvalid
	case cantProcessMessage

	case documentsMessageIsNil
	case documentsMessageIsInvalid
}

public class WebMessageProcessService {

	public init() { }

	public func process(message: Any) -> Error? {

		func getJsonData(from message: Any) -> Data? {
			if message is String {
				return nil
			}

			guard let jsonString = jsonStringWithObject(obj: message as AnyObject) else {
				return nil
			}

			guard let jsonData = jsonString.data(using: .utf8) else {
				return nil
			}

			return jsonData
		}

		guard let jsonData = getJsonData(from: message) else {
			return WebMessageProcessorErrors.messageIsInvalid
		}

		guard let baseMessageModel: BaseMessageModel = decode(from: jsonData) else {
			return WebMessageProcessorErrors.cantProcessMessage
		}

		switch baseMessageModel.type {

		case .sourceDone:
			guard let decodedModel: SourceDoneModel = decode(from: jsonData) else {
				return WebMessageProcessorErrors.cantProcessMessage
			}

			UserDefaultsManager.container.set(true, forKey: decodedModel.source)

		case .dataAssembled:
			guard let _: DataAssembledModel = decode(from: jsonData) else {
				return WebMessageProcessorErrors.cantProcessMessage
			}

			UserDefaultsManager.container.set(jsonData, forKey: MessageTypes.dataAssembled.rawValue)
		}

		return nil
	}

	public func processDocuments() -> Error? {
		guard let data = UserDefaultsManager.container.data(forKey: MessageTypes.dataAssembled.rawValue) else {
			return WebMessageProcessorErrors.documentsMessageIsNil
		}

		guard let decodedModel: DataAssembledModel = decode(from: data) else {
			return WebMessageProcessorErrors.documentsMessageIsInvalid
		}

		for document in decodedModel.documents {

			let payload = document.payload.split(separator: ",")

			guard payload.count == 2 else {
				return WebMessageProcessorErrors.documentsMessageIsInvalid
			}

			guard let data: Data = Data(base64Encoded: String(payload[1])) else {
				return WebMessageProcessorErrors.documentsMessageIsInvalid
			}

			let fileExtension: String

			if payload[0].contains("pdf") {
				fileExtension = ".pdf"
			} else if payload[0].contains("png") {
				fileExtension = ".png"
			} else {
				return WebMessageProcessorErrors.documentsMessageIsInvalid
			}

			guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
				return WebMessageProcessorErrors.documentsMessageIsInvalid
			}

			if let error = saveFile(with: document.description + fileExtension, with: data, at: url) {
				return error
			}

		}

		return nil
	}

	private func saveFile(with name: String, with data: Data, at url: URL) -> Error? {
		let url = url.appendingPathComponent(name)

		do {
			try data.write(to: url)
		} catch {
			return error
		}

		return nil
	}

	private func saveError(error: Any) {
		var errors = UserDefaultsManager.container.array(forKey: "test") ?? []
		errors.append(error)
		UserDefaultsManager.container.set(errors, forKey: "test")
	}

	private func decode<T: Decodable>(from data: Data) -> T? {
		do {
			let result = try JSONDecoder().decode(T.self, from: data)
			return result
		} catch {
			return nil
		}
	}

	private func jsonStringWithObject(obj: AnyObject) -> String? {
		 do {
			 let jsonData = try JSONSerialization.data(withJSONObject: obj)
			 return String(data: jsonData, encoding: String.Encoding.utf8)
		 } catch {
			 return nil
		 }
	 }
}
