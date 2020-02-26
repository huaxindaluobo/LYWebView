//
//  LYWebViewController.swift
//  LYWebView
//
//  Created by 刘洋 on 2020/2/26.
//  Copyright © 2020 佳缘. All rights reserved.
//

import UIKit
import WebKit

class LYWebViewController: UIViewController {

    var url = URL(string: "")
    var eventBlock:(()->())
    
    //逃逸闭包
    init(url:URL, eventBlock:@escaping (()->())) {
        self.eventBlock = eventBlock
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /** 注册js与oc交互的方法 */
        registerJS()
        /** UI布局 */
        setupUI()
        
       
    }
    
    func setupUI() {
        let webView = LYWebView(frame: self.view.frame, url: self.url?.absoluteString ?? "")
        webView.delegate = self
        self.view.addSubview(webView)
        
    }
    
    func registerJS()  {
        LYWebViewMethodManger.addMethod(name: "jumpTo") { (params) in
            let alter = UIAlertController(title: nil, message: params, preferredStyle: .alert)
            let cancle = UIAlertAction(title: "cancle", style: .cancel) { (action) in
                print("==========\(params)===========")
            }
            alter.addAction(cancle)
            self.present(alter, animated: true, completion: nil)
            
            
            
        }
    }

}

extension LYWebViewController:LYWebViewDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("window.document.title") { (result, error) in
            self.title = result as? String
        }
    }
    
    
}
