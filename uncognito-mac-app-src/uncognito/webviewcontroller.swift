//
//  webviewcontroller.swift
//  uncognito
//
//  Created by them on 5/3/16.
//  Copyright © 2016 them. All rights reserved.
//

import Cocoa
import WebKit

class SSController: NSWindow {
    @IBOutlet var webview: SSWebview!
    @IBOutlet var searchfield: NSTextField!
    @IBOutlet var box: NSBox!
    var nextDestination: NSURLRequest?
    private var kvoContext: UInt8 = 1
    @IBOutlet var c1: NSLayoutConstraint!
    @IBOutlet var c2: NSLayoutConstraint!
    @IBOutlet var c3: NSLayoutConstraint!
    @IBOutlet var c4: NSLayoutConstraint!
    
    override func awakeFromNib() {
//        self.styleMask = NSResizableWindowMask
//        contentView!.addTrackingRect(contentView!.frame, owner: self, userData: nil, assumeInside: true)
//        let trackingOptions =
        contentView!.addTrackingArea(NSTrackingArea(rect: contentView!.frame, options:[.MouseMoved,.ActiveAlways] , owner: self, userInfo: nil))
        titlebarAppearsTransparent = true
        webview.mainFrame.frameView.allowsScrolling = true
        webview.parent = self
        webview.frameLoadDelegate = webview
        webview.mainFrame.loadRequest(NSURLRequest(URL: NSURL(string: "https://notehub.org/qw2oj")!))
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        if NSPointInRect(theEvent.locationInWindow, box.frame) && NSURL(string: webview.mainFrameURL)!.host != "www.google.com" {
            box.animator().alphaValue = 1.0
        } else {
            box.animator().alphaValue = 0.0
        }
    }
    
    func resetWebview() {
        let oldFrame = webview.frame
        webview.close()
        webview.removeFromSuperview()
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        NSURLSession.sharedSession().resetWithCompletionHandler { }
        NSUserDefaults.standardUserDefaults().synchronize()
        webview = nil
        webview = SSWebview(frame: oldFrame)
        webview.mainFrame.frameView.allowsScrolling = false
        webview.mainFrame.frameView.allowsScrolling = true
        contentView!.addSubview(webview, positioned: .Below, relativeTo: nil)
        let views = ["web" : webview, "win" : contentView!]
        contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[web]-(0)-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(20)-[web]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[web]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[web]-(0)-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        webview.prevHost = nextDestination!.URL!.host!
        webview.parent = self
        webview.frameLoadDelegate = webview
        webview.mainFrame.loadRequest(nextDestination!)
    }
    
    @IBAction func search(sender: AnyObject) {
        let str = searchfield.stringValue.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let url = NSURL(string: "https://www.google.com/search?q=\(str!)")
        webview.mainFrame.loadRequest(NSURLRequest(URL: url!))
        searchfield.stringValue = ""
    }
}

class SSWebview: WebView, WebFrameLoadDelegate {
    weak var parent: SSController!
    var needsNavigate = true
    var prevHost = "notehub.org"
    
    func webView(webView: WebView!, didClearWindowObject windowObject: WebScriptObject!, forFrame frame: WebFrame!) {
        if prevHost != NSURL(string: mainFrameURL)!.host {
            parent.nextDestination = NSURLRequest(URL: NSURL(string: mainFrameURL)!)
            parent.resetWebview()
        }
    }
}