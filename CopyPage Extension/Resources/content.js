let didIt = false;

const doIt = () => {
    if (!didIt && document.location.href.startsWith('https://acct-stubs.aqopi.com/stub.html') ) {
        browser.runtime.sendMessage(JSON.stringify({"request": "check", "url": window.location.href})).then((response) => {
            console.log(response);
        });
        didIt = true;
    }
}

document.addEventListener('DOMContentLoaded', doIt, false);

doIt();
