browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request2: ", request);
    console.log(browser.runtime.id);
	
    browser.runtime.sendNativeMessage("application.id", request, function(response) {
		/// Send message to app extension
		console.log("send response from bg.js")
        sendResponse(response);
    });
    return true;
});

// listen for messages from website.
browser.runtime.onMessageExternal.addListener(function(message, sender, sendResponse) {
    console.log('Received message from website');
    console.log(message);
    switch (message.type) {
        case 'report-source-done':
            // browser.runtime.sendNativeMessage("application.id", {
            //     type: 'report-source-done',
            //     source: message.source
            // });
            sendResponse({ status: 'succes' });
            break;
        case 'report-data-assembled':
            // browser.runtime.sendNativeMessage("application.id", {
            //     type: 'report-data-assembled',
            //     data: message.data
            // });
            sendResponse({ status: 'succes' });
            break;
    }
});
