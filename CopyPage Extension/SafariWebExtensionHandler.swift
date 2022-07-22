//
//  SafariWebExtensionHandler.swift
//  CopyPage Extension
//
//  Created by Tim van der Heijden on 16/07/2022.
//

import SafariServices
import os.log

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


		/// Share message with application
		groupUserDefaults?.set(message, forKey: "test")

		// send it to the content.js 

        context.completeRequest(returningItems: [response], completionHandler: nil)
    }
}
