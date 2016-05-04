console.log("Attempting to inject payload...");
var s = document.createElement('script');
s.src = chrome.extension.getURL("payload.js");
(document.head||document.documentElement).appendChild(s);
//s.parentNode.removeChild(s);