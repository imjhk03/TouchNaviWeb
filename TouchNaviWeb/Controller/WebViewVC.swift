//
//  WebViewVC.swift
//  Touchy
//
//  Created by Joo Hee Kim on 2018. 1. 15..
//  Copyright © 2018년 Joo Hee Kim. All rights reserved.
//

import UIKit
// To use WebKitWebView, import Webkit
import WebKit

class WebViewVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var webView: WKWebView!
    var webSite: String?
    var mark_webSite: String?
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func back(sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func forward(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    override func viewDidLoad() {
        // add webView to the main View
//        view.addSubview(webView) before
        // show progressView above webView
        view.insertSubview(webView, aboveSubview: progressView)
        
        // disable auto-generated constraints
        webView.translatesAutoresizingMaskIntoConstraints = false
        // define height and width constraints for the webView. It will have the same height and width like superview's height and width. At height, added toolbar so let constant to -44.
        let height = NSLayoutConstraint(item: webView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: -44)
        let width = NSLayoutConstraint(item: webView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
        
        // loading property
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        // estimatedProgress property (when progressing, load progressView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        // load url
        if let address = webSite {
            let webURL = URL(string: address)
            let urlRequest = URLRequest(url: webURL!)
            webView.load(urlRequest)
        }
        
        // mainstory -> webViewVC -> View Controller -> Extend Edges -> uncheck Under Top Bars
        // —> 상위 바 투명화 제거(뒤에 웹페이지가 불투명하게 나타나는 부분을 제거)
        
        backButton.isEnabled = false
        forwardButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // initializes the web view with frame of size zero
    required init?(coder aDecoder: NSCoder) {
        self.webView = WKWebView(frame: .zero)
        super.init(coder: aDecoder)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // whenever the observable property changes this method is called. The web view current state will changed the back and forward buttons. If the web view is "loading" set the buttons enabled if canGoBack or canGoForward
        if (keyPath == "loading") {
            backButton.isEnabled = webView.canGoBack
            forwardButton.isEnabled = webView.canGoForward
        }
        // changes the progressView's progress bar according to webView estimated progess value
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    // WKNavigationDelegate protocol method, this method loads when page load completes
    // resets the progress view value after each request
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }

}
