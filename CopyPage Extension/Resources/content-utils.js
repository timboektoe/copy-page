function messageToBackground(msg) {
    chrome.runtime.sendMessage(msg);
}

function __handleActionError(msg) {
    messageToBackground({name: 'page-event', event: '&error', msg: msg});
}

const actionHandler = {};

actionHandler['GET-OUTER-HTML'] = function (request) {
    __waitUntilElementDisplayed(request.selector, function(el) {
        var html = el.outerHTML;

        messageToBackground({
            name: 'page-event',
            event: '&get-outer-html-success',
            url: window.location.href,
            id: request.htmlId,
            type: 'HTML',
            payload: btoa(unescape(encodeURIComponent(html)))
        });

    }, function () {
        messageToBackground({
            name: 'page-event',
            event: '&get-outer-html-success',
            url: window.location.href,
            id: request.htmlId,
            type: 'HTML',
            payload: btoa(unescape(encodeURIComponent('<div></div>')))
        });
    });
};

actionHandler['DOWNLOAD-XML'] = function (request) {
    __getDownloadUrl(request, function(url) {
        var xhr = new XMLHttpRequest();

        xhr.open('GET', url, true);

        xhr.onload = function() {
            try {
                if (xhr.status === 200) {
                    messageToBackground({
                        name: 'page-event',
                        event: '&download-success',
                        type: 'XML',
                        url: url,
                        payload: xhr.response,
                        id: request.xmlId,
                        filename: request.xmlName,
                        addDocInd: request.addDocInd,
                        parseInd: request.parseInd
                    });
                } else {
                    __handleActionError('Error downloading XML: ' + xhr.statusText);
                }
            } catch (error) {
                __handleActionError('Error downloading XML: ' + xhr.statusText);
            }
        };

        xhr.onerror = function () {
            __handleActionError('Error downloading XML: ' + xhr.statusText);
        };

        xhr.send(null);
    });
};

actionHandler['DOWNLOAD-PDF'] = function (request) {
    __getDownloadUrl(request, function (url) {
        if (url) {
            __fetchBlob(url, function (result) {
                messageToBackground({
                    name: 'page-event',
                    event: '&download-success',
                    type: 'PDF',
                    url: url,
                    payload: result,
                    id: request.docId,
                    filename: request.docName,
                    addDocInd: request.addDocInd,
                    parseInd: request.parseInd
                });
            });
        } else {
            __handleActionError('Element with selector ' + '"' + request.selector + '"' + ' not visible in time.');
        }
    });
};

function __waitUntilElementDisplayed(selector, succesCallback, errorCallback) {
    var targetEl, intervalRef, count = 0;

    const getElement = (selector, targetEl) => {
        const el = targetEl || document;
        let newEl = null;

        try {
            if (typeof selector === 'string') {
                newEl = el.querySelector(selector);
            } else if (typeof selector === 'object' && !Array.isArray(selector) && selector !== null) {
                newEl = el.querySelector(selector.selector);
                newEl = newEl && selector.hasShadowRoot ? newEl.shadowRoot : newEl;

                if (selector.childSelector) {
                    newEl = newEl ? getElement(selector.childSelector, newEl) : newEl
                }
            }
        } catch(error) {

        }


        return newEl;
    }

    targetEl = getElement(selector);
    if (targetEl) {
        succesCallback(targetEl);
    } else {
        intervalRef = setInterval(function () {
            targetEl = getElement(selector);
            if (targetEl) {
                clearInterval(intervalRef);
                succesCallback(targetEl);
            } else {
                count++;
                if (count > 3) {
                    clearInterval(intervalRef);
                    errorCallback();
                }
            }
        }, 1000);
    }
}

function __getDownloadUrl(request, callback) {
    if (request.url) {
        callback(request.url);
    } else if (request.selector) {
        __waitUntilElementDisplayed(request.selector, function () {
            callback(document.querySelector(request.selector).href);
        }, function () {
            callback('');
        });
    }
}