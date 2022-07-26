let didIt = false;

const doIt = () => {
	console.log("Hello world!")
    if (!didIt && document.location.href.startsWith('https://acct-stubs.aqopi.com/stub.html') ) {
        browser.runtime.sendMessage(JSON.stringify({"request": "check", "url": window.location.href})).then((response) => {
			console.log("Hi content js:")
            console.log(response);
			/// redirect after send message to background
//            window.location.href = 'https://example.com/' // response.url
        });
        didIt = true;
    }
}

document.addEventListener('DOMContentLoaded', doIt, false);
doIt();

// 1. We open some page form the app
// UIApplication.shared.openURL()
// 2. Send message to background.js with our current url

// 3. In background.js we send message to the app extension
// 4. App extension send object to background.js and the object with new url property (example.com)
// 5. bg.js invoke some function in content.js
