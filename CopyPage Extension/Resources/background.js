browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);

    browser.runtime.sendNativeMessage("application.id", request, function(response) {
        sendResponse(response);
    });
    return true;
});
