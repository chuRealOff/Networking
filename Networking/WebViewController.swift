//
//  WebViewController.swift
//  Networking
//
//  Created by CHURILOV DMITRIY on 06.12.2022.
//

import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var selectedCourse: String?
    var coursrURL = ""
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedCourse
        
        guard let url = URL(string: coursrURL) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
