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
        window.webkitRequestFileSystem = RFSSwizzle
    }
    
    
    // Run all IM hack methods. 
    function init() {
        swizzleRequestFileSystem();
        window.pootis = 5
    }
    init();
})()



