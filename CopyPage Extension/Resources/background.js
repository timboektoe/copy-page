browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);
	
    browser.runtime.sendNativeMessage("application.id", request, function(response) {
		/// Send message to app extension
		console.log("send response from bg.js")
        sendResponse(response);
    });
    return true;
});
