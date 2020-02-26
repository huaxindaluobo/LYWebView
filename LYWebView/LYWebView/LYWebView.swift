//
//  LYWebView.swift
//  LYWebView
//
//  Created by 刘洋 on 2020/2/26.
//  Copyright © 2020 佳缘. All rights reserved.
//

import UIKit
import WebKit

protocol LYWebViewDelegate {
    
}

class LYWebView: UIView {
    var webView = WKWebView()
    var url = ""
    init(frame: CGRect,url:String) {
        self.url = url
        super.init(frame: frame)
        setupUI()
        registerJS()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController()
        configuration.preferences = WKPreferences()
        webView = WKWebView(frame: self.frame, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        if let newUrl = URL(string: self.url) {
            let request = URLRequest(url: newUrl)
            webView.load(request)
            
        }
        self.addSubview(webView)
    }
    
    func registerJS() {
        for method in LYWebViewMethodManger.methodDic.keys {
            self.webView.configuration.userContentController.add(LYWebViewMethodManger(), name: method)
        }
    }
    
   
}

/** 扩展遵循WKNavigationDelegate协议 */
extension LYWebView:WKNavigationDelegate {
    
    /** Decides whether to allow or cancel a navigation.发起请求的时候 */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("---------------1----------------")
        decisionHandler(.allow)
    }
    /** 效果同上一个，如果实现了这个方法，上一个方法不会调用 */
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
//
//    }
    
    /** webView的Content开始在webview上加载 */
      func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
           print("---------------2----------------")
      }
    
    /** Invoked when an error occurs while starting to load data for
    the main frame. */
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("3-----error----------\(error)----------------")
    }
    
    /** Decides whether to allow or cancel a navigation after its
    response is known. */
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("---------------3----------------")
        decisionHandler(.allow)
    }
    
    
    /** 开始接收webview的content */
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("---------------4----------------")
    }
    
    
    /** called when the navigation finished */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         print("---------------5----------------")
    }
   
    /** called when The Navigation error */
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         print("error---------------\(error)----------------")
    }
    
    
    
    
    /** 应该是重定向 */
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    /** httpsw没有自建证书的权限认证方法 */
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if challenge.previousFailureCount == 0 {
                let crid = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                completionHandler(.useCredential,crid)
            }else{
                completionHandler(.cancelAuthenticationChallenge,nil)
            }
        }else{
            completionHandler(.cancelAuthenticationChallenge,nil)
        }
    }
    
}

extension LYWebView:WKUIDelegate {
    
}
