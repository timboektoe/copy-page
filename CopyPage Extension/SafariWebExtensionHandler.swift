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

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

	/// Shared container with app
	let groupUserDefaults = UserDefaults(suiteName: "group.copypage.safariappextension")

	/// Receive message from background.js
    func beginRequest(with context: NSExtensionContext) {

        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)
		NSLog("Message Received: %@", message as! CVarArg)

        let response = NSExtensionItem()
        response.userInfo = [SFExtensionMessageKey: [ "Response to": message ]]

		if let message = message as? String {
			processMessage(message: message)
		}
		/// Share message with application
//		groupUserDefaults?.set(message, forKey: "test")

		// send it to the content.js 

        context.completeRequest(returningItems: [response], completionHandler: nil)
    }

	func processMessage(message: String) {
		do {
			guard let messageData = message.data(using: .utf8) else { return }
			let result = try JSONDecoder().decode(MessageModel.self, from: messageData)
			groupUserDefaults?.set(true, forKey: result.url)
		} catch {
			print(error.localizedDescription)
		}
	}
}
