//
//  ViewController.swift
//  CopyPage
//
//  Created by Tim van der Heijden on 16/07/2022.
//

import UIKit
import WebKit
import SafariServices
import os.log

class ViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {

    @IBOutlet var webView: WKWebView!


    /*
     Screen should show a button. When the use clicks the button, the app should open safari webbrowser pointing to:
     https://acct-stubs.aqopi.com/stub.html?source=moh&profile=test&timeout=0&redirects=0&redirectTimeout=0
     */

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.navigationDelegate = self
        self.webView.scrollView.isScrollEnabled = false

        self.webView.configuration.userContentController.add(self, name: "controller")

        self.webView.loadFileURL(Bundle.main.url(forResource: "Main", withExtension: "html")!, allowingReadAccessTo: Bundle.main.resourceURL!)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Override point for customization.
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // Override point for customization.
    }
    
    override func beginRequest(with context: NSExtensionContext) {
        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        print("Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)

        let response = NSExtensionItem()
        response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ] ]
            
        context.completeRequest(returningItems: [response], completionHandler: nil)
    }
}
