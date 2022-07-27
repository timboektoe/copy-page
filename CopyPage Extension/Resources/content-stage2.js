document.addEventListener('DOMContentLoaded', () => {
    if (document.location.href.startsWith('https://acct-stubs.aqopi.com/stub.html') ) {
        const urlParams = new URLSearchParams(window.location.search);
        const source = urlParams.get('source') || null;

        if (source) {
            browser.runtime.sendMessage(JSON.stringify({
                source: source,
                status: 'done'
            }));
        }
    }
}, false);