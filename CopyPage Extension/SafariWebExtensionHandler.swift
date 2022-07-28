//
//  SafariWebExtensionHandler.swift
//  CopyPage Extension
//
//  Created by Tim van der Heijden on 16/07/2022.
//

import SafariServices
import os.log

struct MessageModel: Codable {
	let request: String
	let url: String
}

enum ExtensionMessageProcessingErros: LocalizedError {
	case noMessage
	case noMessageData
	case cantCreateURL
	case cantCreateComponents
	case noSourceQuery
	case cantDecodeMessage
}

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

	/// Shared container with app
	let groupUserDefaults = UserDefaults(suiteName: "group.copypage.safariappextension")!

	/// Receive message from background.js
    func beginRequest(with context: NSExtensionContext) {

        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]

        let response = NSExtensionItem()
        response.userInfo = [SFExtensionMessageKey: [ "Response to": message ]]

		if let message = message as? String {
			processMessage(message: message)
		} else {
			saveError(error: .noMessage)
		}

        context.completeRequest(returningItems: [response], completionHandler: nil)
    }


	func processMessage(message: String) {
		do {
			guard let messageData = message.data(using: .utf8) else {
				saveError(error: .noMessageData)
				return
			}

			let result = try JSONDecoder().decode(MessageModel.self, from: messageData)

			guard let url = URL(string: result.url) else {
				saveError(error: .cantCreateURL)
				return
			}

			guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
				saveError(error: .cantCreateComponents)
				return
			}

			let sourceQuery = urlComponents.queryItems?.first {
				$0.name == "source"
			}

			guard let sourceQueryValue = sourceQuery?.value else {
				saveError(error: .noSourceQuery)
				return
			}

			groupUserDefaults.set(true, forKey: sourceQueryValue)

		} catch {
			saveError(error: .cantDecodeMessage)
		}
	}

	func saveError(error: ExtensionMessageProcessingErros) {
		var errors = groupUserDefaults.array(forKey: "extensionErrors") ?? []
		errors.append("Date: \(Date()) \n Error: \(error.localizedDescription)")
		groupUserDefaults.set(errors, forKey: "extensionErrors")
	}
}
