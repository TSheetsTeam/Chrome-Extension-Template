(function () {
    "use strict";
    
    console.log("Executing payload.");
    
    // Initialize payload data
    var swizzles = {};
    
    
    // Replace the request file system variable with the temporary
    // file system. Defeats check that RFS returns an error in IM.
    function swizzleRequestFileSystem() {
        console.log("Swizzling RFS...");
        swizzles["RequestFileSystem"] = window.RequestFileSystem;
        swizzles["webkitRequestFileSystem"] = window.webkitRequestFileSystem;
        var RFSSwizzle = function (type, duration, callbackSuccess, callbackErr) {
            callbackSuccess({});
        };
        window.RequestFileSystem = RFSSwizzle;
        window.webkitRequestFileSystem = RFSSwizzle;
    }
    
    function swizzleRequestMediaKeySystemAccess() {
        console.log("Swizzling MKS update...");
        window.pootis = 3;
        swizzles["MediaKeySession.update"] = MediaKeySession.update;
        MediaKeySession.update = function (a,b) {
            console.log("Running MKS update swizzle.");
            return new Promise(function (resolve, reject) {
                console.log("Resolving MKS update automatically...");
                resolve();
            });
        };
    }
    
    // Run all IM hack methods. 
    function init() {
        swizzleRequestMediaKeySystemAccess();
        swizzleRequestFileSystem();
        window.pootis = 5
    }
    init();
})()



