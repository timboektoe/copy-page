browser.runtime.onMessageExternal.addListener(function(message, sender, sendResponse) {
    console.log('Received message from website');
    console.log(message);
    switch (message.type) {
        case 'report-source-done':
            // TODO Maksym: In new version (stage 5) this should result in a green checkmark on the tile.
            browser.runtime.sendNativeMessage("application.id", {
                type: 'report-source-done',
                source: message.source
            });
            sendResponse({ status: 'succes' });
            break;
        case 'report-data-assembled':
            // TODO Maksym: This communicates the assembled data. In the new version (stage 5) this message should be handled
            // to build up the screen with the documents.
            // See https://iwize.nl/gd-app-integration/assets/document-collection.json for an example json
            browser.runtime.sendNativeMessage("application.id", {
                type: 'report-data-assembled',
                documents: message.documents
            });
            sendResponse({ status: 'succes' });
            break;
    }
});
