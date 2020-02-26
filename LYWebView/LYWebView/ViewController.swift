//
//  ViewController.swift
//  LYWebView
//
//  Created by 刘洋 on 2020/2/26.
//  Copyright © 2020 佳缘. All rights reserved.
/*
 对WKWebView的二次封装
 疑问：
 1.user-agent
 
 
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


    @IBAction func baidu(_ sender: Any) {
        if let url =  URL(string: "https://www.baidu.com")  {
            let lyWebVc = LYWebViewController(url:url) {
                
            }
            self.navigationController?.pushViewController(lyWebVc, animated: true)
        }
    }
    
    @IBAction func account(_ sender: Any) {
        if let url =  URL(string: "https://apph5.baihe.com/user/perCenter?uid=186973728&version=10.16.0&channel=ios")  {
            let lyWebVc = LYWebViewController(url:url) {
                
            }
            self.navigationController?.pushViewController(lyWebVc, animated: true)
        }
    }
}

